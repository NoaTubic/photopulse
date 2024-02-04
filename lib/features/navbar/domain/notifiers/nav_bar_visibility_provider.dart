import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

final navBarVisibilityProvider =
    StateNotifierProvider<NavBarVisibilityProvider, bool>(
  (ref) => NavBarVisibilityProvider(ref),
);

class NavBarVisibilityProvider extends SimpleStateNotifier<bool> {
  NavBarVisibilityProvider(Ref ref) : super(ref, true);

  void toggleNavBarVisibility() {
    state = !state;
  }
}
