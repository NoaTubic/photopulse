import 'package:q_architecture/base_state_notifier.dart';

extension BaseStateExtension on BaseState {
  bool get isLoading {
    return this is BaseLoading;
  }

  bool get isError {
    return this is BaseError;
  }

  BaseError get asError {
    if (this is BaseError) {
      return this as BaseError;
    } else {
      throw StateError('The current state is not an error state.');
    }
  }
}
