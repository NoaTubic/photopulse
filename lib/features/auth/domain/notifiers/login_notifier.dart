import 'package:photopulse/features/auth/data/repository/auth_repository.dart';

import 'package:photopulse/features/auth/domain/entities/user_credentials.dart';
import 'package:photopulse/features/auth/domain/notifiers/user_notifier.dart';
import 'package:photopulse/features/auth/forms/login_form_config.dart';
import 'package:q_architecture/base_state_notifier.dart';
import 'package:q_architecture/q_architecture.dart';

final loginNotifierProvider = BaseStateNotifierProvider<LoginNotifier, void>(
  (ref) => LoginNotifier(
    ref.read(authRepositoryProvider),
    ref.read(loginFormMapperProvider),
    ref,
  ),
);

class LoginNotifier extends BaseStateNotifier<void> {
  final AuthRepository _authRepository;
  final FormMapper<UserCredentials> _userCredentialsMapper;

  LoginNotifier(this._authRepository, this._userCredentialsMapper, super.ref);

  Future<void> login(
    Map<String, dynamic> formMap,
  ) {
    final userCredentials = _userCredentialsMapper(formMap);
    return execute(
      _authRepository.login(userCredentials: userCredentials),
      onFailureOccurred: (failure) {
        state = BaseState.error(failure);
        return false;
      },
    );
  }

  Future<void> loginWithGoogle() => execute(
        _authRepository.loginWithGoogle(),
        onFailureOccurred: (failure) {
          state = BaseState.error(failure);
          return false;
        },
      );

  Future<void> loginAnonymously() => execute(
        _authRepository.loginAnonymously(),
        onFailureOccurred: (failure) {
          state = BaseState.error(failure);
          return false;
        },
        onDataReceived: (_) =>
            ref.read(isAnonymousProvider.notifier).state = true,
      );
}
