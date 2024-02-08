import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

final hashtagNotifierProvider =
    StateNotifierProvider<HashtagNotifier, List<String>>(
  (ref) => HashtagNotifier(ref),
);

class HashtagNotifier extends SimpleStateNotifier<List<String>> {
  HashtagNotifier(Ref ref) : super(ref, []);

  void addHashtag(String hashtag) {
    state = [...state, '#$hashtag'];
  }

  void removeHashtag(String hashtag) {
    state = state.where((element) => element != hashtag).toList();
  }
}
