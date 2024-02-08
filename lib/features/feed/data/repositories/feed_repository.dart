import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/data/firestore/firestore_collections.dart';
import 'package:photopulse/features/post/domain/entities/post.dart';
import 'package:q_architecture/paginated_notifier.dart';
import 'package:q_architecture/q_architecture.dart';

final feedRepositoryProvider = Provider<FeedRepository>((ref) {
  return FeedRepositoryImpl();
});

abstract class FeedRepository {
  PaginatedEitherFailureOr<Post> getFeed(int? page);
}

class FeedRepositoryImpl implements FeedRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _postsCollection = FirestoreCollections.postsCollection;

  DocumentSnapshot? _lastDocument;
  bool _hasMorePosts = true;
  int _currentPage = 0;

  @override
  PaginatedEitherFailureOr<Post> getFeed(int? page) async {
    Query query =
        _postsCollection.orderBy('createdAt', descending: true).limit(10);

    if (_lastDocument != null && page != null && page > 1) {
      query = query.startAfterDocument(_lastDocument!);
    }

    final QuerySnapshot querySnapshot = await query.get();
    if (querySnapshot.docs.isNotEmpty) {
      _lastDocument = querySnapshot.docs.last;
    }

    if (querySnapshot.docs.length < 10) _hasMorePosts = false;

    for (final doc in querySnapshot.docs) {
      log(doc.data().runtimeType.toString());
      log(doc.data().toString());
    }
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
