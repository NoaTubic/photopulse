import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/features/subscription_management/data/repositories/subscription_management_repository.dart';
import 'package:photopulse/features/subscription_management/domain/entities/subscription_package.dart';
import 'package:q_architecture/base_state_notifier.dart';

final subscriptionManagementNotifierProvider =
    BaseStateNotifierProvider<SubscriptionManagementNotifier, void>(
  (ref) => SubscriptionManagementNotifier(
    ref.watch(subscriptionManagementRepositoryProvider),
    ref,
  ),
);

class SubscriptionManagementNotifier extends BaseStateNotifier<void> {
  final SubscriptionManagementRepository _subscriptionManagementRepository;
  SubscriptionManagementNotifier(
      this._subscriptionManagementRepository, super.ref);

  Future<void> updateUserSubscriptionPackage({String? id}) => execute(
        _subscriptionManagementRepository.updateUserSubscriptionPackage(
          ref.read(selectedSubscriptionPackageProvider),
          id,
        ),
        globalLoading: true,
        onFailureOccurred: (failure) {
          state = BaseState<void>.error(failure);
          return false;
        },
      );
}

final selectedSubscriptionPackageProvider = StateProvider<SubscriptionPackage>(
  (ref) => SubscriptionPackage.free,
);
