import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/features/feed/data/repositories/feed_repository.dart';
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
      : super(ref, const PaginatedState.loading());

  @override
  PaginatedEitherFailureOr<Post> getListOrFailure(
    int page, [
    Object? parameter,
  ]) {
    return _feedRepository.getFeed(page);
  }
}
