import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/features/auth/data/repository/auth_repository.dart';
import 'package:photopulse/features/auth/domain/entities/user.dart';
import 'package:q_architecture/q_architecture.dart';

final userProvider = StateNotifierProvider<UserNotifier, PhotoPulseUser?>(
  (ref) {
    return UserNotifier(
      ref.watch(authRepositoryProvider),
      ref,
    )..getUser();
  },
);

class UserNotifier extends SimpleStateNotifier<PhotoPulseUser?> {
  final AuthRepository _authRepository;

  UserNotifier(this._authRepository, Ref ref) : super(ref, null);

  bool get isFirstLogin => state?.isFirstLogin ?? false;

  Future<void> getUser() async => _authRepository.getSignedInUser().listen(
        (user) {
          user.fold(
            (failure) => null,
            (user) {
              state = user;

              // setUser(user.id);
            },
          );
        },
      );
}
