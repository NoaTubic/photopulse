import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/features/post/data/data_sources/posts_local_data_source.dart';
import 'package:photopulse/features/post/data/models/post_isar_model.dart';
import 'package:photopulse/features/search_posts/data/builders/post_query_builder.dart';
import 'package:photopulse/features/post/domain/entities/post.dart';
import 'package:q_architecture/paginated_notifier.dart';
import 'package:q_architecture/q_architecture.dart';

final feedRepositoryProvider = Provider<FeedRepository>((ref) {
  return FeedRepositoryImpl(
    ref.watch(postQueryBuilderProvider),
    ref.watch(postsLocalDataSourceProvider),
  );
});

abstract class FeedRepository {
  PaginatedEitherFailureOr<Post> getFeed({
    int? page,
    String hashtag,
    bool dateDescending,
    bool sizeDescending,
    String? authorId,
    bool isOnline,
  });
}

class FeedRepositoryImpl implements FeedRepository {
  final PostQueryBuilder _postQueryBuilder;
  final PostsLocalDataSource _postsLocalDataSource;

  FeedRepositoryImpl(this._postQueryBuilder, this._postsLocalDataSource);

  DocumentSnapshot? _lastDocument;
  bool _hasMorePosts = true;
  int _currentPage = 0;

  @override
  PaginatedEitherFailureOr<Post> getFeed({
    int? page,
    String? hashtag,
    bool dateDescending = false,
    bool sizeDescending = false,
    String? authorId,
    bool isOnline = true,
  }) async {
    List<Post> posts;

    if (!isOnline) {
      posts = await _postsLocalDataSource.getCachedPosts();
      _hasMorePosts = false;
    } else {
      _postQueryBuilder.reset();
      _postQueryBuilder.addHashtagFilter(hashtag ?? '');
      _postQueryBuilder.addAuthorFilter(authorId);
      _postQueryBuilder.sortByDate(dateDescending);
      _postQueryBuilder.sortBySize(sizeDescending);

      Query query = _postQueryBuilder.build();

      if (_lastDocument != null && page != null && page > 1) {
        query = query.startAfterDocument(_lastDocument!);
      }

      final QuerySnapshot querySnapshot = await query.get();
      if (querySnapshot.docs.isNotEmpty) {
        _lastDocument = querySnapshot.docs.last;
      }

      if (querySnapshot.docs.length < 10) _hasMorePosts = false;

      posts = querySnapshot.docs.map((doc) => doc.data() as Post).toList();

      await _postsLocalDataSource.cacheLatestPosts(
        posts.map((post) => postToIsar(post)).toList(),
      );
    }
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
