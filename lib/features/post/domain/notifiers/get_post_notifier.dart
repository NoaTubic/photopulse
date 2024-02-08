import 'package:photopulse/features/post/data/repositories/post_repository.dart';
import 'package:photopulse/features/post/domain/entities/post.dart';
import 'package:q_architecture/base_state_notifier.dart';

final getPostNotifierProvider =
    BaseStateNotifierProvider<GetPostNotifier, Post>(
  (ref) => GetPostNotifier(
    ref.watch(postRepositoryProvider),
    ref,
  ),
);

class GetPostNotifier extends BaseStateNotifier<Post> {
  final PostRepository _postRepository;

  GetPostNotifier(this._postRepository, super.ref);

  Future<void> getPost(String id) => execute(
        _postRepository.getPost(id),
      );
}
