import 'package:photopulse/features/auth/data/repository/auth_repository.dart';
import 'package:photopulse/features/profile/data/models/change_password_request.dart';
import 'package:photopulse/features/profile/forms/change_password_form_config.dart';
import 'package:q_architecture/base_state_notifier.dart';
import 'package:q_architecture/q_architecture.dart';

final changePasswordNotifierProvider =
    BaseStateNotifierProvider<ChangePasswordNotifier, void>(
  (ref) => ChangePasswordNotifier(
    ref.watch(authRepositoryProvider),
    ref.watch(changePasswordFormMapper),
    ref,
  ),
);

class ChangePasswordNotifier extends BaseStateNotifier<void> {
  final AuthRepository _authRepository;
  final FormMapper<ChangePasswordRequest> _changePasswordFormMapper;

  ChangePasswordNotifier(
    this._authRepository,
    this._changePasswordFormMapper,
    super.ref,
  );

  Future<void> changePassword(Map<String, dynamic> formMap) async {
    final changePasswordRequest = _changePasswordFormMapper(formMap);
    execute(
      _authRepository.changePassword(changePasswordRequest),
      onFailureOccurred: (failure) {
        state = BaseState.error(failure);
        return false;
      },
    );
  }
}
