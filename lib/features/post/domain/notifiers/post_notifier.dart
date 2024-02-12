import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photopulse/common/utils/file_extensions.dart';
import 'package:photopulse/features/auth/domain/notifiers/user_notifier.dart';
import 'package:photopulse/features/post/data/repositories/post_repository.dart';
import 'package:photopulse/features/post/domain/entities/author.dart';
import 'package:photopulse/features/post/domain/entities/post.dart';
import 'package:photopulse/features/post/domain/entities/post_form_data.dart';
import 'package:photopulse/features/post/domain/notifiers/hashtag_notifer.dart';
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
    File? file,
  }) async {
    final postFormData = _postUpdateRequestMapper(formMap);
    final user = ref.read(userProvider);
    final tags = ref.read(hashtagNotifierProvider);
    if (post != null) {
      await execute(
        _postRepository.updatePost(
          post.copyWith(
              id: post.id,
              title: postFormData.title,
              caption: postFormData.caption,
              tags: tags),
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
            tags: tags,
            sizeInMB: file?.sizeInMB ?? post!.sizeInMB,
          ),
        ),
      );
    }
  }

  Future<void> deletePost(Post post) =>
      execute(_postRepository.deletePost(post), globalLoading: true);

  Future<void> updatePost(Post post) => execute(
        _postRepository.updatePost(post),
      );
}
