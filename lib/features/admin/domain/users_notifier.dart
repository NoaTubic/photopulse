import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/features/auth/data/repository/users_repository.dart';
import 'package:photopulse/features/auth/domain/entities/user.dart';
import 'package:q_architecture/q_architecture.dart';

final usersNotifierProvider =
    StateNotifierProvider<UsersNotifier, List<PhotoPulseUser>>(
  (ref) => UsersNotifier(
    ref.watch(usersRepositoryProvider),
    ref,
  ).._init(),
);

class UsersNotifier extends SimpleStateNotifier<List<PhotoPulseUser>> {
  final UsersRepository _usersRepository;
  StreamSubscription? _usersSubscription;

  UsersNotifier(this._usersRepository, Ref ref) : super(ref, []);

  void _init() {
    _usersSubscription = _usersRepository.getUsersStream().listen(
      (eitherFailureOrUsers) {
        eitherFailureOrUsers.fold(
          (failure) => state = [], // Handle failure state
          (users) => state = users,
        );
      },
    );
  }

  @override
  void dispose() {
    _usersSubscription?.cancel();
    super.dispose();
  }
}
