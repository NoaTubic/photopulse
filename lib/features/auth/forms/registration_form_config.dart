import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/features/auth/data/model/registration_request.dart';
import 'package:q_architecture/q_architecture.dart';

final registrationFormMapperProvider =
    Provider<FormMapper<RegistrationRequest>>(
  (_) => RegistrationFormConfig.userCredentialsFromJson,
);

abstract class RegistrationFormConfig {
  static const usernameKey = 'username';
  static const emailKey = 'email';
  static const passwordKey = 'password';
  static const confirmPasswordKey = 'confirmPassword';

  static RegistrationRequest userCredentialsFromJson(
    Map<String, dynamic> formMap,
  ) =>
      RegistrationRequest(
        username: formMap[usernameKey],
        email: formMap[emailKey],
        password: formMap[passwordKey],
      );
}
