import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/features/feed/data/repositories/feed_repository.dart';
import 'package:photopulse/features/feed/domain/notifiers/filters_notifier.dart';
import 'package:photopulse/features/search_posts/domain/notifiers/search_query_provider.dart';
import 'package:photopulse/features/post/domain/entities/post.dart';
import 'package:q_architecture/paginated_notifier.dart';

final searchPostsNotifierProvider =
    StateNotifierProvider<SearchPostsNotifier, PaginatedState<Post>>(
  (ref) => SearchPostsNotifier(
    ref.watch(feedRepositoryProvider),
    ref,
  ),
);

class SearchPostsNotifier extends PaginatedNotifier<Post, Object> {
  final FeedRepository _feedRepository;

  SearchPostsNotifier(this._feedRepository, Ref ref)
      : super(ref, const PaginatedState.loaded([]));

  @override
  PaginatedEitherFailureOr<Post> getListOrFailure(
    int page, [
    Object? parameter,
  ]) {
    final filters = ref.read(filtersNotifierProvider);
    final query = ref.read(searchQueryProvider);
    return _feedRepository.getFeed(
      page: page,
      hashtag: query.isNotEmpty ? '#$query' : '',
      dateDescending: filters.dateDescending,
      sizeDescending: filters.sizeDescending,
      authorId: filters.authorId,
    );
  }
}
