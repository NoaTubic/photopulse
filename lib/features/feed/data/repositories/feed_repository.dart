import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/features/feed/data/builders/post_query_builder.dart';
import 'package:photopulse/features/post/domain/entities/post.dart';
import 'package:q_architecture/paginated_notifier.dart';
import 'package:q_architecture/q_architecture.dart';

final feedRepositoryProvider = Provider<FeedRepository>((ref) {
  return FeedRepositoryImpl(ref.watch(postQueryBuilderProvider));
});

abstract class FeedRepository {
  PaginatedEitherFailureOr<Post> getFeed({
    int? page,
    String hashtag,
    double? minImageSizeMb,
    double? maxImageSizeMb,
    DateTimeRange? dateTimeRange,
    String? authorId,
  });
}

class FeedRepositoryImpl implements FeedRepository {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final _postsCollection = FirestoreCollections.postsCollection;
  final PostQueryBuilder _postQueryBuilder;

  FeedRepositoryImpl(this._postQueryBuilder);

  DocumentSnapshot? _lastDocument;
  bool _hasMorePosts = true;
  int _currentPage = 0;

  @override
  PaginatedEitherFailureOr<Post> getFeed({
    int? page,
    String? hashtag,
    double? minImageSizeMb,
    double? maxImageSizeMb,
    DateTimeRange? dateTimeRange,
    String? authorId,
  }) async {
    _postQueryBuilder.addHashtagFilter(hashtag ?? '');
    _postQueryBuilder.addSizeFilter(minImageSizeMb, maxImageSizeMb);
    _postQueryBuilder.addDateTimeRangeFilter(dateTimeRange);
    _postQueryBuilder.addAuthorFilter(authorId);

    Query query = _postQueryBuilder.build();

    if (_lastDocument != null && page != null && page > 1) {
      query = query.startAfterDocument(_lastDocument!);
    }

    final QuerySnapshot querySnapshot = await query.get();
    if (querySnapshot.docs.isNotEmpty) {
      _lastDocument = querySnapshot.docs.last;
    }

    if (querySnapshot.docs.length < 10) _hasMorePosts = false;

    final List<Post> posts =
        querySnapshot.docs.map((doc) => doc.data() as Post).toList();

    return Right(
      PaginatedList(
        data: posts,
        page: page ?? _currentPage + 1,
        isLast: !_hasMorePosts,
      ),
    );
  }

  void resetPagination() {
    _lastDocument = null;
    _hasMorePosts = true;
    _currentPage = 0;
  }
}
