import 'package:photopulse/features/auth/data/repository/auth_repository.dart';

import 'package:photopulse/features/auth/domain/entities/user_credentials.dart';
import 'package:q_architecture/base_state_notifier.dart';
import 'package:q_architecture/q_architecture.dart';

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
    );
  }
}
