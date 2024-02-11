import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/features/post/data/repositories/post_repository.dart';
import 'package:q_architecture/q_architecture.dart';

final hashtagNotifierProvider =
    StateNotifierProvider<HashtagNotifier, List<String>>(
  (ref) => HashtagNotifier(ref.watch(postRepositoryProvider), ref),
);

class HashtagNotifier extends SimpleStateNotifier<List<String>> {
  final PostRepository _postRepository;
  HashtagNotifier(this._postRepository, Ref ref) : super(ref, []);

  Future<void> getHashtags(String? postId) async {
    if (postId == null) return;
    final post = await _postRepository.getPost(postId);
    post.fold(
      (failure) => log('Error getting post'),
      (post) {
        state = post.tags;
      },
    );
  }

  void addHashtag(String hashtag) {
    log(hashtag);
    state = [...state, '#$hashtag'];
  }

  void removeHashtag(String hashtag) {
    state = state.where((element) => element != hashtag).toList();
  }
}
