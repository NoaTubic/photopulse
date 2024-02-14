import 'package:photopulse/features/auth/data/model/registration_request.dart';
import 'package:photopulse/features/auth/data/repository/auth_repository.dart';
import 'package:photopulse/features/auth/forms/registration_form_config.dart';
import 'package:q_architecture/base_state_notifier.dart';
import 'package:q_architecture/q_architecture.dart';

final registrationNotifierProvider =
    BaseStateNotifierProvider<RegistrationNotifier, void>(
  (ref) => RegistrationNotifier(
    ref.read(authRepositoryProvider),
    ref.read(registrationFormMapperProvider),
    ref,
  ),
);

class RegistrationNotifier extends BaseStateNotifier<void> {
  final AuthRepository _authRepository;
  final FormMapper<RegistrationRequest> _registrationRequestMapper;

  RegistrationNotifier(
    this._authRepository,
    this._registrationRequestMapper,
    super.ref,
  );

  Future<void> register(
    Map<String, dynamic> formMap,
  ) {
    final registrationRequest = _registrationRequestMapper(formMap);
    return execute(
      _authRepository.register(registrationRequest: registrationRequest),
      onFailureOccurred: (failure) {
        state = BaseState.error(failure);
        return false;
      },
      onDataReceived: (_) {
        _authRepository.verifyEmail();
        return true;
      },
    );
  }

  Future<void> verifyEmail() async => _authRepository.verifyEmail();
}
