import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/data/firebase_error_resolver.dart';
import 'package:photopulse/common/data/firestore/firestore_collections.dart';
import 'package:photopulse/features/auth/domain/entities/user.dart';
import 'package:photopulse/features/subscription_management/domain/entities/subscription_package.dart';
import 'package:q_architecture/q_architecture.dart';

final userRepositoryProvider = Provider<UsersRepository>(
  (ref) => UserRepositoryImpl(FirebaseAuth.instance),
);

abstract class UsersRepository {
  EitherFailureOr<void> initializeUser();

  StreamFailureOr<PhotoPulseUser> getSignedInUser();

  Future<void> deleteSignedInUser();

  EitherFailureOr<void> updateUserSubscriptionPackage(
    SubscriptionPackage subscriptionPackage,
  );

  EitherFailureOr<void> incrementDailyUpload();
}

class UserRepositoryImpl with ErrorToFailureMixin implements UsersRepository {
  final FirebaseAuth _firebaseAuth;
  final _usersCollection = FirestoreCollections.usersCollection;

  UserRepositoryImpl(this._firebaseAuth);

  @override
  EitherFailureOr<void> initializeUser() async => execute(
        () async {
          final currentUser = _firebaseAuth.currentUser;

          final userDoc = await _usersCollection.doc(currentUser?.uid).get();
          if (!userDoc.exists) {
            await _usersCollection.doc(currentUser?.uid).set(
                  PhotoPulseUser(
                    id: currentUser!.uid,
                    email: currentUser.email!,
                    username: currentUser.displayName!,
                    photoUrl: currentUser.photoURL ?? '',
                  ),
                );
          }
          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );

  @override
  StreamFailureOr<PhotoPulseUser> getSignedInUser() {
    final currentUser = _firebaseAuth.currentUser;

    return _usersCollection.doc(currentUser?.uid).snapshots().map((snapshot) {
      final user = snapshot.data();
      return user != null ? Right(user) : Left(Failure.generic());
    });
  }

  @override
  Future<void> deleteSignedInUser() {
    throw UnimplementedError();
  }

  @override
  EitherFailureOr<void> updateUserSubscriptionPackage(
    SubscriptionPackage subscriptionPackage,
  ) async =>
      execute(
        () async {
          final userDocRef =
              _usersCollection.doc(_firebaseAuth.currentUser?.uid);

          final userDoc = await userDocRef.get();
          if (userDoc.exists) {
            await userDocRef.update({
              'subscriptionPackage': subscriptionPackage.name,
              'isFirstLogin': false,
              'canChangeSubscription': false,
            });
          } else {
            throw Exception('User not found');
          }

          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );

  @override
  EitherFailureOr<void> incrementDailyUpload() async => execute(
        () async {
          final userDocRef =
              _usersCollection.doc(_firebaseAuth.currentUser?.uid);

          final userDoc = await userDocRef.get();
          if (userDoc.exists) {
            await userDocRef.update({
              'dailyUploads': FieldValue.increment(1),
            });
          } else {
            throw Exception('User not found');
          }

          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );
}
