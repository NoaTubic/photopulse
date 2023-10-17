import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/features/auth/domain/entities/user_credentials.dart';
import 'package:q_architecture/q_architecture.dart';

final loginFormMapperProvider = Provider<FormMapper<UserCredentials>>(
  (_) => LoginFormConfig.userCredentialsFromJson,
);

abstract class LoginFormConfig {
  static const emailKey = 'email';
  static const passwordKey = 'password';

  static UserCredentials userCredentialsFromJson(
    Map<String, dynamic> formMap,
  ) =>
      UserCredentials(
        email: formMap[emailKey],
        password: formMap[passwordKey],
      );
}
