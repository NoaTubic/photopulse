// ignore_for_file: always_use_package_imports
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/data/firebase_error_resolver.dart';
import 'package:photopulse/features/auth/domain/entities/user_credentials.dart';
import 'package:q_architecture/q_architecture.dart';

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepositoryImpl());

abstract interface class AuthRepository {
  EitherFailureOr<void> register({
    required String email,
    required String password,
  });

  EitherFailureOr<void> verifyEmail();

  EitherFailureOr<void> login({
    required UserCredentials userCredentials,
  });

  EitherFailureOr<void> loginWithGoogle();

  EitherFailureOr<void> signInAnonymously();
}

class AuthRepositoryImpl with ErrorToFailureMixin implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  EitherFailureOr<void> register({
    required String email,
    required String password,
  }) =>
      execute(
        () async {
          await _firebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
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
  EitherFailureOr<void> login({
    required UserCredentials userCredentials,
  }) =>
      execute(
        () async {
          await _firebaseAuth.signInWithEmailAndPassword(
            email: userCredentials.email,
            password: userCredentials.password,
          );
          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );

  @override
  EitherFailureOr<void> loginWithGoogle() {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }

  @override
  EitherFailureOr<void> signInAnonymously() => execute(
        () async {
          await _firebaseAuth.signInAnonymously();
          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );
}
