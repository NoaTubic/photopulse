import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/data/firebase_error_resolver.dart';
import 'package:photopulse/common/data/wrappers/firebase_wrappers.dart';
import 'package:photopulse/features/subscription_management/domain/entities/subscription_package.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:q_architecture/q_architecture.dart';

final subscriptionManagementRepositoryProvider =
    Provider<SubscriptionManagementRepository>(
  (ref) => SubscriptionManagementRepositoryImpl(FirebaseWrappers()),
);

abstract interface class SubscriptionManagementRepository {
  EitherFailureOr<void> updateUserSubscriptionPackage(
    SubscriptionPackage subscriptionPackage,
    String? userId,
  );
}

class SubscriptionManagementRepositoryImpl
    with ErrorToFailureMixin
    implements SubscriptionManagementRepository {
  final FirebaseWrappers _firebase;

  SubscriptionManagementRepositoryImpl(this._firebase);

  @override
  EitherFailureOr<void> updateUserSubscriptionPackage(
    SubscriptionPackage subscriptionPackage,
    String? userId,
  ) async =>
      execute(
        () async {
          final userDocRef = _firebase.usersCollection
              .doc(userId ?? _firebase.firebaseAuth.currentUser?.uid);

          final userDoc = await userDocRef.get();
          if (userDoc.exists) {
            await userDocRef.update(
              {
                'subscriptionPackage': subscriptionPackage.name,
                'isFirstLogin': false,
                'canChangeSubscription': false,
              },
            );
          } else {
            return Left(Failure(title: S.current.user_not_found));
          }

          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );
}
