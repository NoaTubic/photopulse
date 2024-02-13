import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/features/feed/data/repositories/feed_repository.dart';
import 'package:photopulse/features/feed/domain/notifiers/filters_notifier.dart';
import 'package:photopulse/features/search_posts/domain/notifiers/search_query_provider.dart';
import 'package:photopulse/features/post/domain/entities/post.dart';
import 'package:q_architecture/paginated_notifier.dart';

final feedNotifierProvider =
    StateNotifierProvider<FeedNotifier, PaginatedState<Post>>(
  (ref) => FeedNotifier(
    ref.watch(feedRepositoryProvider),
    ref,
  )..getInitialList(),
);

class FeedNotifier extends PaginatedNotifier<Post, Object> {
  final FeedRepository _feedRepository;

  FeedNotifier(this._feedRepository, Ref ref)
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
