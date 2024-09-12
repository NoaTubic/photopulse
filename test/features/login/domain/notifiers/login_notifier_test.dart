import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:photopulse/features/login/data/repositories/login_repository.dart';
import 'package:photopulse/features/auth/domain/entities/user_credentials.dart';
import 'package:photopulse/features/login/domain/notifiers/login_notifier.dart';
import 'package:q_architecture/base_state_notifier.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(
        const UserCredentials(email: 'test@example.com', password: 'password'));
  });

  late ProviderContainer providerContainer;
  final mockedLoginRepository = MockLoginRepository();
  late UserCredentials Function(Map<String, dynamic>) mockedFormMapper;

  final provider = BaseStateNotifierProvider<LoginNotifier, void>(
    (ref) => LoginNotifier(
      mockedLoginRepository,
      mockedFormMapper,
      ref,
    ),
  );

  setUp(() {
    mockedFormMapper = (Map<String, dynamic> formMap) => UserCredentials(
        email: formMap['email'] as String,
        password: formMap['password'] as String);
  });

  group('login', () {
    stateNotifierTest<LoginNotifier, BaseState<void>>(
      'should emit [BaseLoading, BaseData] when login is successful',
      setUp: () {
        when(() => mockedLoginRepository.login(
                userCredentials: any(named: 'userCredentials')))
            .thenAnswer((_) async => const Right(null));
        providerContainer = ProviderContainer();
      },
      build: () => providerContainer.read(provider.notifier),
      actions: (stateNotifier) async => stateNotifier
          .login({'email': 'test@example.com', 'password': 'password'}),
      expect: () => [
        const BaseState<Never>.loading(),
        const BaseState<void>.data(null),
      ],
    );

    stateNotifierTest<LoginNotifier, BaseState<void>>(
      'should emit [BaseLoading, BaseError] when login fails',
      setUp: () {
        when(() => mockedLoginRepository.login(
                userCredentials: any(named: 'userCredentials')))
            .thenAnswer(
                (_) async => const Left(Failure(title: 'Login failed')));
        providerContainer = ProviderContainer();
      },
      build: () => providerContainer.read(provider.notifier),
      actions: (stateNotifier) => stateNotifier
          .login({'email': 'test@example.com', 'password': 'password'}),
      expect: () => [
        const BaseState<Never>.loading(),
        const BaseState<void>.error(Failure(title: 'Login failed')),
      ],
    );
  });

  group('loginWithGoogle', () {
    stateNotifierTest<LoginNotifier, BaseState<void>>(
      'should emit [BaseLoading, BaseData] when Google login is successful',
      setUp: () {
        when(() => mockedLoginRepository.loginWithGoogle())
            .thenAnswer((_) async => const Right(null));
        providerContainer = ProviderContainer();
      },
      build: () => providerContainer.read(provider.notifier),
      actions: (stateNotifier) => stateNotifier.loginWithGoogle(),
      expect: () => [
        const BaseState<Never>.loading(),
        const BaseState<void>.data(null),
      ],
    );

    stateNotifierTest<LoginNotifier, BaseState<void>>(
      'should emit [BaseLoading, BaseError] when Google login fails',
      setUp: () {
        when(() => mockedLoginRepository.loginWithGoogle()).thenAnswer(
            (_) async => const Left(Failure(title: 'Google login failed')));
        providerContainer = ProviderContainer();
      },
      build: () => providerContainer.read(provider.notifier),
      actions: (stateNotifier) => stateNotifier.loginWithGoogle(),
      expect: () => [
        const BaseState<Never>.loading(),
        const BaseState<void>.error(Failure(title: 'Google login failed')),
      ],
    );
  });

  group('loginAnonymously', () {
    stateNotifierTest<LoginNotifier, BaseState<void>>(
      'should emit [BaseLoading, BaseData] when anonymous login is successful',
      setUp: () {
        when(() => mockedLoginRepository.loginAnonymously())
            .thenAnswer((_) async => const Right(null));
        providerContainer = ProviderContainer();
      },
      build: () => providerContainer.read(provider.notifier),
      actions: (stateNotifier) => stateNotifier.loginAnonymously(),
      expect: () => [
        const BaseState<Never>.loading(),
        const BaseState<void>.data(null),
      ],
    );

    stateNotifierTest<LoginNotifier, BaseState<void>>(
      'should emit [BaseLoading, BaseError] when anonymous login fails',
      setUp: () {
        when(() => mockedLoginRepository.loginAnonymously()).thenAnswer(
            (_) async => const Left(Failure(title: 'Anonymous login failed')));
        providerContainer = ProviderContainer();
      },
      build: () => providerContainer.read(provider.notifier),
      actions: (stateNotifier) => stateNotifier.loginAnonymously(),
      expect: () => [
        const BaseState<Never>.loading(),
        const BaseState<void>.error(Failure(title: 'Anonymous login failed')),
      ],
    );
  });
}
