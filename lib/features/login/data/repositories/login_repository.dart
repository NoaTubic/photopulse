// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:either_dart/either.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/data/firebase_error_resolver.dart';
import 'package:photopulse/features/auth/data/repository/users_repository.dart';
import 'package:photopulse/features/login/data/wrappers/google_wrapper.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:photopulse/common/data/wrappers/firebase_wrapper.dart';
import 'package:photopulse/features/auth/domain/entities/user_credentials.dart';

final loginRepositoryProvider = Provider<LoginRepository>(
  (ref) => LoginRepositoryImpl(
    FirebaseWrapper(),
    GoogleWrapper(),
    ref.read(usersRepositoryProvider),
  ),
);

abstract interface class LoginRepository {
  EitherFailureOr<void> login({
    required UserCredentials userCredentials,
  });

  EitherFailureOr<void> loginWithGoogle();

  EitherFailureOr<void> loginAnonymously();
}

class LoginRepositoryImpl with ErrorToFailureMixin implements LoginRepository {
  final FirebaseWrapper _firebase;
  final GoogleWrapper _google;
  final UsersRepository _usersRepository;

  LoginRepositoryImpl(
    this._firebase,
    this._google,
    this._usersRepository,
  );

  @override
  EitherFailureOr<void> login({
    required UserCredentials userCredentials,
  }) =>
      execute(
        () async {
          await _firebase.signInWithEmailAndPassword(
            email: userCredentials.email,
            password: userCredentials.password,
          );

          if (!_firebase.firebaseAuth.currentUser!.emailVerified) {
            return Left(Failure(title: S.current.email_not_verified));
          }
          await _usersRepository.initializeUser();
          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );

  @override
  EitherFailureOr<void> loginWithGoogle() => execute(
        () async {
          final GoogleSignInAccount? googleUser = await _google.signIn();
          if (googleUser == null) {
            return Left(
              Failure(title: S.current.google_sign_in_canceled),
            );
          } else {
            final googleAuth = await googleUser.authentication;
            final authCredential =
                await _google.getGoogleAuthCredential(googleAuth);

            await _firebase.firebaseAuth.signInWithCredential(authCredential);
          }
          await _usersRepository.initializeUser();
          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );

  @override
  EitherFailureOr<void> loginAnonymously() => execute(
        () async {
          await _firebase.firebaseAuth.signInAnonymously();
          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );
}
