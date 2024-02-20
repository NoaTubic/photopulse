import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/data/firebase_error_resolver.dart';
import 'package:photopulse/common/data/firestore/firestore_collections.dart';
import 'package:photopulse/features/auth/domain/entities/user.dart';
import 'package:photopulse/features/subscription_management/domain/entities/subscription_package.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:q_architecture/q_architecture.dart';

final usersRepositoryProvider = Provider<UsersRepository>(
  (ref) => UserRepositoryImpl(FirebaseAuth.instance),
);

abstract class UsersRepository {
  EitherFailureOr<void> initializeUser();

  StreamFailureOr<PhotoPulseUser> getSignedInUser();

  Future<void> deleteSignedInUser();

  EitherFailureOr<void> updateUserSubscriptionPackage(
    SubscriptionPackage subscriptionPackage,
    String? userId,
  );

  EitherFailureOr<void> incrementDailyUploadAndTotalUploadSize(double sizeInMB);

  EitherFailureOr<List<PhotoPulseUser>> getUsers();

  StreamFailureOr<List<PhotoPulseUser>> getUsersStream();

  EitherFailureOr<void> changeEmail(String email);

  EitherFailureOr<void> changeUsername(String username, String? userId);

  EitherFailureOr<void> clearStatistics(String userId);

  EitherFailureOr<void> changeProfilePicture(String imageUrl, String? userId);

  EitherFailureOr<void> removeProfilePicture(String? userId);
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

    return _usersCollection.doc(currentUser?.uid).snapshots().map(
      (snapshot) {
        final user = snapshot.data();
        return user != null ? Right(user) : Left(Failure.generic());
      },
    );
  }

  @override
  Future<void> deleteSignedInUser() {
    throw UnimplementedError();
  }

  @override
  EitherFailureOr<void> updateUserSubscriptionPackage(
    SubscriptionPackage subscriptionPackage,
    String? userId,
  ) async =>
      execute(
        () async {
          final userDocRef =
              _usersCollection.doc(userId ?? _firebaseAuth.currentUser?.uid);

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

  @override
  EitherFailureOr<void> incrementDailyUploadAndTotalUploadSize(
          double sizeInMB) async =>
      execute(
        () async {
          final userDocRef =
              _usersCollection.doc(_firebaseAuth.currentUser?.uid);

          final userDoc = await userDocRef.get();
          if (userDoc.exists) {
            await userDocRef.update({
              'dailyUploads': FieldValue.increment(1),
              'totalUploadSizeInMB': FieldValue.increment(sizeInMB),
            });
          } else {
            throw Exception('User not found');
          }

          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );

  @override
  EitherFailureOr<List<PhotoPulseUser>> getUsers() async => execute(
        () async {
          final users = await _usersCollection.get();
          return Right(users.docs.map((doc) => doc.data()).toList());
        },
        errorResolver: const FirebaseErrorResolver(),
      );

  @override
  StreamFailureOr<List<PhotoPulseUser>> getUsersStream() {
    return _usersCollection.snapshots().map(
      (snapshot) {
        try {
          final users = snapshot.docs.map((doc) => doc.data()).toList();
          return Right(users);
        } catch (e) {
          return Left(const FirebaseErrorResolver().resolve(e));
        }
      },
    );
  }

  @override
  EitherFailureOr<void> changeEmail(String email) async => execute(() async {
        FirebaseAuth.instance.currentUser!.verifyBeforeUpdateEmail(email);
        return const Right(null);
      }, errorResolver: const FirebaseErrorResolver());

  @override
  EitherFailureOr<void> changeUsername(String username, String? userId) async =>
      execute(
        () async {
          final userDocRef =
              _usersCollection.doc(userId ?? _firebaseAuth.currentUser?.uid);

          final userDoc = await userDocRef.get();
          if (userDoc.exists) {
            await userDocRef.update(
              {
                'username': username,
              },
            );
          } else {
            return Left(Failure(title: S.current.user_not_found));
          }

          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );

  @override
  EitherFailureOr<void> clearStatistics(String userId) => execute(
        () async {
          final userDocRef = _usersCollection.doc(userId);

          final userDoc = await userDocRef.get();
          if (userDoc.exists) {
            await userDocRef.update(
              {
                'dailyUploads': 0,
                'totalUploadSizeInMB': 0,
                'maxSpend': 0,
              },
            );
          } else {
            return Left(Failure(title: S.current.user_not_found));
          }

          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );

  @override
  EitherFailureOr<void> changeProfilePicture(
          String imageUrl, String? userId) async =>
      execute(
        () async {
          final path = await _storeImage(imageUrl);
          final userDocRef =
              _usersCollection.doc(userId ?? _firebaseAuth.currentUser?.uid);

          final userDoc = await userDocRef.get();
          if (userDoc.exists) {
            await userDocRef.update(
              {
                'photoUrl': path,
              },
            );
          } else {
            return Left(Failure(title: S.current.user_not_found));
          }

          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );

  @override
  EitherFailureOr<void> removeProfilePicture(String? userId) async => execute(
        () async {
          final userDocRef =
              _usersCollection.doc(userId ?? _firebaseAuth.currentUser?.uid);

          final userDoc = await userDocRef.get();
          if (userDoc.exists) {
            await userDocRef.update(
              {
                'photoUrl': '',
              },
            );
          } else {
            return Left(Failure(title: S.current.user_not_found));
          }

          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );

  Future<String> _storeImage(
    String path,
  ) async {
    final imageRef = FirebaseStorage.instance.ref().child('photos').child(path);
    await imageRef.putFile(File(path));
    final imageUrl = await imageRef.getDownloadURL();
    return imageUrl;
  }
}
