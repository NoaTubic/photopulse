import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:photopulse/features/auth/domain/entities/user_credentials.dart';
import 'package:either_dart/either.dart';
import 'package:photopulse/common/data/wrappers/firebase_wrapper.dart';
import 'package:photopulse/features/auth/data/repository/users_repository.dart';
import 'package:photopulse/features/login/data/repositories/login_repository.dart';
import 'package:photopulse/features/login/data/wrappers/google_wrapper.dart';
import 'package:photopulse/generated/l10n.dart';

class MockFirebaseWrapper extends Mock implements FirebaseWrapper {}

class MockGoogleWrapper extends Mock implements GoogleWrapper {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

class MockUsersRepository extends Mock implements UsersRepository {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

class MockUserCredential extends Mock implements UserCredential {}

class MockOAuthCredential extends Mock implements OAuthCredential {}

void main() {
  late MockFirebaseWrapper mockFirebaseWrapper;
  late MockGoogleWrapper mockGoogleWrapper;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUsersRepository mockUsersRepository;
  late MockUser mockUser;
  late LoginRepositoryImpl loginRepository;

  setUp(() {
    S.load(const Locale('en'));
    mockFirebaseWrapper = MockFirebaseWrapper();
    mockGoogleWrapper = MockGoogleWrapper();
    mockFirebaseAuth = MockFirebaseAuth();
    mockUsersRepository = MockUsersRepository();
    mockUser = MockUser();
    loginRepository = LoginRepositoryImpl(
      mockFirebaseWrapper,
      mockGoogleWrapper,
      mockUsersRepository,
    );
    when(() => mockFirebaseWrapper.firebaseAuth).thenReturn(mockFirebaseAuth);
  });

  test('should log in successfully with verified email', () async {
    const userCredentials =
        UserCredentials(email: 'test@example.com', password: 'password');

    when(() => mockFirebaseWrapper.signInWithEmailAndPassword(
          email: userCredentials.email,
          password: userCredentials.password,
        )).thenAnswer((_) async {});

    when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
    when(() => mockUser.emailVerified).thenReturn(true);

    when(() => mockUsersRepository.initializeUser()).thenAnswer((_) async {
      return const Right(null);
    });

    final result =
        await loginRepository.login(userCredentials: userCredentials);

    expect(result.isRight, true);
    verify(() => mockFirebaseWrapper.signInWithEmailAndPassword(
          email: userCredentials.email,
          password: userCredentials.password,
        )).called(1);
    verify(() => mockUsersRepository.initializeUser()).called(1);
  });

  test('should return FirebaseAuthException on login failure', () async {
    const userCredentials =
        UserCredentials(email: 'test@example.com', password: 'password');

    final exception = FirebaseAuthException(
      code: 'user-not-found',
      message: 'No user found for that email.',
    );

    when(() => mockFirebaseWrapper.signInWithEmailAndPassword(
          email: userCredentials.email,
          password: userCredentials.password,
        )).thenThrow(exception);

    final result =
        await loginRepository.login(userCredentials: userCredentials);

    expect(result.isLeft, true);
    result.fold(
      (failure) {
        expect(failure.title, S.current.login_error_wrong_credentials);
      },
      (_) => fail('Expected Left, but got Right'),
    );

    verify(() => mockFirebaseWrapper.signInWithEmailAndPassword(
          email: userCredentials.email,
          password: userCredentials.password,
        )).called(1);
  });

  group('loginWithGoogle', () {
    test('should log in successfully with Google', () async {
      final mockGoogleUser = MockGoogleSignInAccount();
      final mockGoogleAuth = MockGoogleSignInAuthentication();
      final mockAuthCredential = MockOAuthCredential();
      final mockUserCredential = MockUserCredential();

      when(() => mockGoogleWrapper.signIn())
          .thenAnswer((_) async => mockGoogleUser);
      when(() => mockGoogleUser.authentication)
          .thenAnswer((_) async => mockGoogleAuth);
      when(() => mockGoogleWrapper.getGoogleAuthCredential(mockGoogleAuth))
          .thenAnswer((_) async => mockAuthCredential);
      when(() => mockFirebaseAuth.signInWithCredential(mockAuthCredential))
          .thenAnswer((_) async => mockUserCredential);
      when(() => mockUsersRepository.initializeUser())
          .thenAnswer((_) async => const Right(null));

      final result = await loginRepository.loginWithGoogle();

      expect(result.isRight, true);
      verify(() => mockGoogleWrapper.signIn()).called(1);
      verify(() => mockGoogleUser.authentication).called(1);
      verify(() => mockGoogleWrapper.getGoogleAuthCredential(mockGoogleAuth))
          .called(1);
      verify(() => mockFirebaseAuth.signInWithCredential(mockAuthCredential))
          .called(1);
      verify(() => mockUsersRepository.initializeUser()).called(1);
    });

    test('should return failure when Google sign in is canceled', () async {
      when(() => mockGoogleWrapper.signIn()).thenAnswer((_) async => null);

      final result = await loginRepository.loginWithGoogle();

      expect(result.isLeft, true);
      result.fold(
        (failure) => expect(failure.title, S.current.google_sign_in_canceled),
        (_) => fail('Expected Left, but got Right'),
      );
    });

    test('should return failure when Google sign in throws an exception',
        () async {
      when(() => mockGoogleWrapper.signIn())
          .thenThrow(FirebaseAuthException(code: 'Google sign in failed'));

      final result = await loginRepository.loginWithGoogle();

      expect(result.isLeft, true);
      result.fold(
        (failure) => expect(failure.title, S.current.server_error),
        (_) => fail('Expected Left, but got Right'),
      );
    });
  });

  group('loginAnonymously', () {
    test('should log in successfully anonymously', () async {
      when(() => mockFirebaseAuth.signInAnonymously())
          .thenAnswer((_) async => MockUserCredential());

      final result = await loginRepository.loginAnonymously();

      expect(result.isRight, true);
      verify(() => mockFirebaseAuth.signInAnonymously()).called(1);
    });

    test('should return failure when anonymous login fails', () async {
      when(() => mockFirebaseAuth.signInAnonymously())
          .thenThrow(FirebaseAuthException(code: 'operation-not-allowed'));

      final result = await loginRepository.loginAnonymously();

      expect(result.isLeft, true);
      result.fold(
        (failure) => expect(failure.title, S.current.server_error),
        (_) => fail('Expected Left, but got Right'),
      );
    });
  });
}
