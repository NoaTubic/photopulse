// ignore_for_file: always_use_package_imports
import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/data/firebase_error_resolver.dart';
import 'package:photopulse/common/data/firestore/firestore_collections.dart';
import 'package:photopulse/common/data/generic_error_resolver.dart';
import 'package:photopulse/features/auth/data/constants/github_auth_constants.dart';
import 'package:photopulse/features/auth/data/model/registration_request.dart';
import 'package:photopulse/features/auth/data/repository/users_repository.dart';
import 'package:photopulse/features/auth/domain/entities/github_auth_parameters.dart';
import 'package:photopulse/features/auth/domain/entities/user.dart';
import 'package:photopulse/features/auth/domain/entities/user_credentials.dart';
import 'package:photopulse/features/profile/data/models/change_password_request.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:http/http.dart' as http;

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    ref.watch(usersRepositoryProvider),
  ),
);

abstract interface class AuthRepository {
  EitherFailureOr<void> register({
    required RegistrationRequest registrationRequest,
  });

  EitherFailureOr<void> verifyEmail();

  EitherFailureOr<void> login({
    required UserCredentials userCredentials,
  });

  EitherFailureOr<void> loginWithGoogle();

  EitherFailureOr<void> loginWithGitHub({
    required GithubAuthParameters parameters,
    required String code,
  });

  EitherFailureOr<void> loginAnonymously();

  Stream<User?> subscribeToAuthChanges();

  EitherFailureOr<void> resetPassword({required String email});

  EitherFailureOr<void> changePassword(
      ChangePasswordRequest changePasswordRequest);

  StreamFailureOr<PhotoPulseUser> getSignedInUser();

  Future<void> logout();
}

class AuthRepositoryImpl with ErrorToFailureMixin implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final UsersRepository _usersRepository;
  final _usersCollection = FirestoreCollections.usersCollection;

  AuthRepositoryImpl(this._usersRepository);

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
  EitherFailureOr<void> login({
    required UserCredentials userCredentials,
  }) =>
      execute(
        () async {
          await _firebaseAuth.signInWithEmailAndPassword(
            email: userCredentials.email,
            password: userCredentials.password,
          );

          if (!_firebaseAuth.currentUser!.emailVerified) {
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
          final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
          if (googleUser == null) {
            return Left(
              Failure(title: S.current.google_sign_in_canceled),
            );
          } else {
            final googleAuth = await googleUser.authentication;
            final authCredential = GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken,
            );
            await _firebaseAuth.signInWithCredential(authCredential);
          }
          await _usersRepository.initializeUser();
          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );

  @override
  EitherFailureOr<void> loginWithGitHub({
    required GithubAuthParameters parameters,
    required String code,
  }) =>
      execute(
        () async {
          final Map<String, String> headers = {'Accept': 'application/json'};

          final response = await http.post(
            Uri.parse(GithubAuthConstants.getAccessTokenUrl),
            headers: headers,
            body: {
              'client_id': parameters.clientId,
              'client_secret': parameters.clientSecret,
              'code': code,
            },
          );

          final body = json.decode(utf8.decode(response.bodyBytes));
          final bool hasError = body['error'] != null;
          if (hasError) {
            return Left(
              Failure(
                title: body['error_description'] ??
                    'Unknown Error: ${body.toString()}',
              ),
            );
          }

          // Use cookies in subsequent requests, if necessary
          // Example: http.get(Uri.parse('someUrl'), headers: {'Cookie': getCookieHeader()});

          final AuthCredential credential = GithubAuthProvider.credential(
            body['access_token'],
          );

          await _firebaseAuth.signInWithCredential(credential).then(
                (_) => _usersRepository.initializeUser(),
              );

          return const Right(null);
        },
        errorResolver: const GenericErrorResolver(),
      );

  @override
  EitherFailureOr<void> loginAnonymously() => execute(
        () async {
          await _firebaseAuth.signInAnonymously();
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
        final reauthenticateResult = await login(
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
      await _googleSignIn.signOut();
    } catch (_) {}
  }
}
