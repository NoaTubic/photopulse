// ignore_for_file: always_use_package_imports
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/data/firebase_error_resolver.dart';
import 'package:photopulse/common/data/firestore/firestore_collections.dart';
import 'package:photopulse/features/auth/data/model/registration_request.dart';
import 'package:photopulse/features/auth/domain/entities/user.dart';
import 'package:photopulse/features/auth/domain/entities/user_credentials.dart';
import 'package:photopulse/features/login/data/repositories/login_repository.dart';
import 'package:photopulse/features/login/data/wrappers/google_wrapper.dart';
import 'package:photopulse/features/profile/data/models/change_password_request.dart';
import 'package:q_architecture/q_architecture.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.watch(loginRepositoryProvider)),
);

abstract interface class AuthRepository {
  EitherFailureOr<void> register({
    required RegistrationRequest registrationRequest,
  });

  EitherFailureOr<void> verifyEmail();

  Stream<User?> subscribeToAuthChanges();

  EitherFailureOr<void> resetPassword({required String email});

  EitherFailureOr<void> changePassword(
      ChangePasswordRequest changePasswordRequest);

  StreamFailureOr<PhotoPulseUser> getSignedInUser();

  Future<void> logout();
}

class AuthRepositoryImpl with ErrorToFailureMixin implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final _usersCollection = FirestoreCollections.usersCollection;

  final LoginRepository _loginRepository;

  AuthRepositoryImpl(
    this._loginRepository,
  );

  @override
  EitherFailureOr<void> register({
    required RegistrationRequest registrationRequest,
  }) =>
      execute(
        () async {
          await _firebaseAuth.createUserWithEmailAndPassword(
            email: registrationRequest.email,
            password: registrationRequest.password,
          );
          await _firebaseAuth.currentUser!
              .updateDisplayName(registrationRequest.username);

          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );

  @override
  EitherFailureOr<void> verifyEmail() => execute(
        () async {
          final User? user = _firebaseAuth.currentUser;
          if (user != null && !user.emailVerified) {
            await user.sendEmailVerification();
          }
          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );

  @override
  Stream<User?> subscribeToAuthChanges() async* {
    yield* _firebaseAuth.authStateChanges();
  }

  @override
  StreamFailureOr<PhotoPulseUser> getSignedInUser() {
    final currentUser = _firebaseAuth.currentUser;
    return _usersCollection.doc(currentUser?.uid).snapshots().map((snapshot) {
      final user = snapshot.data();
      return user != null ? Right(user) : Left(Failure.generic());
    });
  }

  @override
  EitherFailureOr<void> changePassword(
          ChangePasswordRequest changePasswordRequest) async =>
      execute(() async {
        final User? user = _firebaseAuth.currentUser;
        final reauthenticateResult = await _loginRepository.login(
          userCredentials: UserCredentials(
              email: user!.email!, password: changePasswordRequest.oldPassword),
        );
        return reauthenticateResult.fold(
          (failure) => const Left(
            Failure(title: 'Wrong password!'),
          ),
          (success) async =>
              user.updatePassword(changePasswordRequest.newPassword).then(
                    (_) => const Right(null),
                  ),
        );
      }, errorResolver: const FirebaseErrorResolver());

  @override
  EitherFailureOr<void> resetPassword({required String email}) async =>
      execute(() async {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
        return const Right(null);
      }, errorResolver: const FirebaseErrorResolver());

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      await GoogleWrapper().signOut();
    } catch (_) {}
  }
}
