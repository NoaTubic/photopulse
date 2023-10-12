import 'package:hooks_riverpod/hooks_riverpod.dart';

final exampleFiltersProvider = StateProvider<String?>((ref) => null);

// This is also possible, subscription will work the same for StateProvider
// and for StateNotifierProvider

// final exampleFiltersProvider =
//     StateNotifierProvider<ExampleFiltersStateNotifier, String?>(
//   (ref) => ExampleFiltersStateNotifier(),
// );

// class ExampleFiltersStateNotifier extends StateNotifier<String?> {
//   ExampleFiltersStateNotifier() : super(null);

//   void update(String? text) => state = text;
// }
