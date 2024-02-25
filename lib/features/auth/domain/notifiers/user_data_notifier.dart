import 'package:photopulse/features/auth/data/repository/users_repository.dart';
import 'package:q_architecture/base_state_notifier.dart';

final userDataNotifierProvider =
    BaseStateNotifierProvider<UserDataNotifier, void>(
  (ref) => UserDataNotifier(
    ref.watch(usersRepositoryProvider),
    ref,
  ),
);

class UserDataNotifier extends BaseStateNotifier<void> {
  final UsersRepository _usersRepository;

  UserDataNotifier(this._usersRepository, super.ref);

  Future<void> changeUsername(
      {required String username, String? userId}) async {
    execute(
      _usersRepository.changeUsername(username, userId),
      globalLoading: true,
    );
  }

  Future<void> changeEmail(String email) async {
    execute(
      _usersRepository.changeEmail(email),
      globalLoading: true,
    );
  }

  Future<void> clearStatistics(String userId) async {
    execute(
      _usersRepository.clearStatistics(userId),
      globalLoading: true,
    );
  }
}
