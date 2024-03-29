import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/features/auth/data/repository/users_repository.dart';
import 'package:photopulse/features/subscription_management/domain/entities/subscription_package.dart';
import 'package:q_architecture/base_state_notifier.dart';

final subscriptionManagementNotifierProvider =
    BaseStateNotifierProvider<SubscriptionManagementNotifier, void>(
  (ref) => SubscriptionManagementNotifier(
    ref.watch(usersRepositoryProvider),
    ref,
  ),
);

class SubscriptionManagementNotifier extends BaseStateNotifier<void> {
  final UsersRepository _usersRepository;
  SubscriptionManagementNotifier(this._usersRepository, super.ref);

  Future<void> updateUserSubscriptionPackage({String? id}) => execute(
        _usersRepository.updateUserSubscriptionPackage(
          ref.read(selectedSubscriptionPackageProvider),
          id,
        ),
        globalLoading: true,
      );
}

final selectedSubscriptionPackageProvider = StateProvider<SubscriptionPackage>(
  (ref) => SubscriptionPackage.free,
);
