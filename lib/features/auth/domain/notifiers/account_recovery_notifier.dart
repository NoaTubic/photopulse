import 'package:photopulse/features/auth/data/repository/auth_repository.dart';
import 'package:q_architecture/base_state_notifier.dart';

final accountRecoveryNotifierProvider =
    BaseStateNotifierProvider<AccountRecoveryNotifier, void>(
  (ref) => AccountRecoveryNotifier(
    ref.watch(authRepositoryProvider),
    ref,
  ),
);

class AccountRecoveryNotifier extends BaseStateNotifier<void> {
  final AuthRepository _authRepository;

  AccountRecoveryNotifier(this._authRepository, super.ref);

  Future<void> resetPassword(String email) async {
    execute(
      _authRepository.resetPassword(email: email),
    );
  }
}
