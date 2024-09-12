import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/utils/base_state_extensions.dart';
import 'package:photopulse/features/subscription_management/data/repositories/subscription_management_repository.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:state_notifier_test/state_notifier_test.dart';
import 'package:photopulse/features/subscription_management/domain/entities/subscription_package.dart';
import 'package:photopulse/features/subscription_management/domain/notifiers/subscription_management_notifier.dart';

import 'package:q_architecture/base_state_notifier.dart';

class MockSubscriptionManagementRepository extends Mock
    implements SubscriptionManagementRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(SubscriptionPackage.free);
  });

  late ProviderContainer providerContainer;
  final mockedUsersRepository = MockSubscriptionManagementRepository();

  final provider =
      BaseStateNotifierProvider<SubscriptionManagementNotifier, void>(
    (ref) => SubscriptionManagementNotifier(
      mockedUsersRepository,
      ref,
    ),
  );

  group('updateUserSubscriptionPackage', () {
    stateNotifierTest<SubscriptionManagementNotifier, BaseState<void>>(
      'should emit [BaseLoading, BaseData] when repository returns success',
      setUp: () {
        when(() => mockedUsersRepository.updateUserSubscriptionPackage(
            any(), any())).thenAnswer((_) async => const Right(null));
        providerContainer = ProviderContainer(
          overrides: [
            selectedSubscriptionPackageProvider
                .overrideWith((ref) => SubscriptionPackage.pro),
          ],
        );
      },
      build: () => providerContainer.read(provider.notifier),
      actions: (stateNotifier) async =>
          stateNotifier.updateUserSubscriptionPackage(),
      expect: () => [
        const BaseState<Never>.loading(),
        const BaseState<void>.data(null),
      ],
    );

    stateNotifierTest<SubscriptionManagementNotifier, BaseState<void>>(
      'should emit [BaseLoading, BaseError] when repository returns failure',
      setUp: () {
        when(() => mockedUsersRepository.updateUserSubscriptionPackage(
                any(), null))
            .thenAnswer(
                (_) async => const Left(Failure(title: 'User not found')));
        providerContainer = ProviderContainer(
          overrides: [
            selectedSubscriptionPackageProvider
                .overrideWith((ref) => SubscriptionPackage.pro),
          ],
        );
      },
      build: () => providerContainer.read(provider.notifier),
      actions: (stateNotifier) => stateNotifier.updateUserSubscriptionPackage(),
      expect: () => [
        const BaseState<Never>.loading(),
        const BaseState<void>.error(Failure(title: 'User not found')),
      ],
    );

    stateNotifierTest<SubscriptionManagementNotifier, BaseState<void>>(
      'should emit [BaseLoading, BaseError] when an unexpected error occurs',
      setUp: () {
        when(() =>
            mockedUsersRepository.updateUserSubscriptionPackage(
                any(), any())).thenAnswer(
            (_) async => const Left(Failure(title: 'Server error occurred')));
        providerContainer = ProviderContainer(
          overrides: [
            selectedSubscriptionPackageProvider
                .overrideWith((ref) => SubscriptionPackage.pro),
          ],
        );
      },
      build: () => providerContainer.read(provider.notifier),
      actions: (stateNotifier) => stateNotifier.updateUserSubscriptionPackage(),
      expect: () => [
        const BaseState<Never>.loading(),
        isA<BaseState<void>>()
            .having((state) => state.isError, 'isError', true)
            .having((state) => (state as BaseError).failure.title,
                'error message', 'Server error occurred'),
      ],
    );

    stateNotifierTest<SubscriptionManagementNotifier, BaseState<void>>(
      'should use specific user ID when provided',
      setUp: () {
        when(() => mockedUsersRepository.updateUserSubscriptionPackage(
            any(), 'test-user-id')).thenAnswer((_) async => const Right(null));
        providerContainer = ProviderContainer(
          overrides: [
            selectedSubscriptionPackageProvider
                .overrideWith((ref) => SubscriptionPackage.pro),
          ],
        );
      },
      build: () => providerContainer.read(provider.notifier),
      actions: (stateNotifier) =>
          stateNotifier.updateUserSubscriptionPackage(id: 'test-user-id'),
      expect: () => [
        const BaseState<Never>.loading(),
        const BaseState<void>.data(null),
      ],
      verify: (_) {
        verify(() => mockedUsersRepository.updateUserSubscriptionPackage(
            any(), 'test-user-id')).called(1);
      },
    );
  });

  group('selectedSubscriptionPackageProvider', () {
    test('initial state is SubscriptionPackage.free', () {
      final container = ProviderContainer();
      final initialPackage =
          container.read(selectedSubscriptionPackageProvider);
      expect(initialPackage, SubscriptionPackage.free);
    });

    test('can update selected package', () {
      final container = ProviderContainer();
      container.read(selectedSubscriptionPackageProvider.notifier).state =
          SubscriptionPackage.pro;
      final updatedPackage =
          container.read(selectedSubscriptionPackageProvider);
      expect(updatedPackage, SubscriptionPackage.pro);
    });
  });
}
