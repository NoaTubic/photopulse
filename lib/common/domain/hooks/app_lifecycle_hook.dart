import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useAppLifecycle({
  required VoidCallback onInitialize,
  required VoidCallback onAppOpen,
}) {
  final currentState = useState(AppLifecycleState.resumed);
  final previousState = useState<AppLifecycleState?>(null);

  useEffect(
    () {
      final observer = HookWidgetsBindingObserver(
        currentState: currentState,
        previousState: previousState,
      );

      WidgetsBinding.instance.addObserver(observer);

      onInitialize();

      return () {
        WidgetsBinding.instance.removeObserver(observer);
        currentState.dispose();
        previousState.dispose();
      };
    },
    [],
  );

  useEffect(
    () {
      if (previousState.value == AppLifecycleState.paused &&
          currentState.value == AppLifecycleState.resumed) {
        onAppOpen();
      }
      return null;
    },
    [currentState.value],
  );
}

//ignore:prefer-match-file-name
class HookWidgetsBindingObserver extends WidgetsBindingObserver {
  final ValueNotifier<AppLifecycleState> currentState;
  final ValueNotifier<AppLifecycleState?> previousState;

  HookWidgetsBindingObserver({
    required this.currentState,
    required this.previousState,
  });

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    previousState.value = currentState.value;
    currentState.value = state;
  }
}
