import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photopulse/features/auth/data/repository/users_repository.dart';
import 'package:photopulse/features/auth/domain/notifiers/user_notifier.dart';
import 'package:photopulse/features/post/data/repositories/post_repository.dart';
import 'package:photopulse/features/post/domain/entities/author.dart';
import 'package:photopulse/features/post/domain/entities/post.dart';
import 'package:photopulse/features/post/domain/entities/post_form_data.dart';
import 'package:photopulse/features/post/forms/post_form_config.dart';
import 'package:q_architecture/base_state_notifier.dart';
import 'package:q_architecture/q_architecture.dart';

final postNotifierProvider = BaseStateNotifierProvider<PostNotifier, void>(
  (ref) => PostNotifier(
    ref.watch(postRepositoryProvider),
    ref.watch(postRequestFormMapperProvider),
    ref,
  ),
);

class PostNotifier extends BaseStateNotifier<void> {
  final PostRepository _postRepository;
  final FormMapper<PostFormData> _postUpdateRequestMapper;

  PostNotifier(
    this._postRepository,
    this._postUpdateRequestMapper,
    super.ref,
  );

  Future<void> submitPostForm({
    required Map<String, dynamic> formMap,
    Post? post,
  }) async {
    final postFormData = _postUpdateRequestMapper(formMap);
    final user = ref.read(userProvider);
    if (post != null) {
      await execute(
        _postRepository.updatePost(
          post.copyWith(
            title: postFormData.title,
            caption: postFormData.caption,
          ),
        ),
      );
    } else {
      await execute(
        _postRepository.createPost(
          Post(
            author: Author.fromUser(user!),
            title: formMap['title'],
            caption: formMap['caption'],
            url: formMap['file'],
            createdAt: Timestamp.now(),
            tags: const [],
          ),
        ),
      );
    }
  }

  Future<void> deletePost(Post post) => execute(
        _postRepository.deletePost(post),
      );

  Future<void> updatePost(Post post) => execute(
        _postRepository.updatePost(post),
      );
}
