// ignore_for_file: subtype_of_sealed_class

import 'dart:ui';

import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photopulse/common/data/wrappers/firebase_wrapper.dart';
import 'package:photopulse/features/auth/domain/entities/user.dart';
import 'package:photopulse/features/subscription_management/data/repositories/subscription_management_repository.dart';
import 'package:photopulse/features/subscription_management/domain/entities/subscription_package.dart';
import 'package:photopulse/generated/l10n.dart';

import 'package:q_architecture/q_architecture.dart';

class MockFirebaseWrappers extends Mock implements FirebaseWrapper {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockCollectionReference extends Mock
    implements CollectionReference<PhotoPulseUser> {}

class MockDocumentReference extends Mock
    implements DocumentReference<PhotoPulseUser> {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<PhotoPulseUser> {}

class MockUser extends Mock implements User {}

void main() {
  late SubscriptionManagementRepositoryImpl repository;
  late MockFirebaseWrappers mockFirebase;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockCollectionReference mockCollectionRef;
  late MockDocumentReference mockDocRef;
  late MockDocumentSnapshot mockDocSnapshot;
  late MockUser mockUser;

  setUp(() {
    S.load(const Locale('en'));

    mockFirebase = MockFirebaseWrappers();
    mockFirebaseAuth = MockFirebaseAuth();
    mockCollectionRef = MockCollectionReference();
    mockDocRef = MockDocumentReference();
    mockDocSnapshot = MockDocumentSnapshot();
    mockUser = MockUser();

    when(() => mockFirebase.usersCollection).thenReturn(mockCollectionRef);
    when(() => mockFirebase.firebaseAuth).thenReturn(mockFirebaseAuth);
    when(() => mockCollectionRef.doc(any())).thenReturn(mockDocRef);
    when(() => mockDocRef.get()).thenAnswer((_) async => mockDocSnapshot);

    repository = SubscriptionManagementRepositoryImpl(mockFirebase);
  });

  group('updateUserSubscriptionPackage', () {
    test('should update subscription package successfully when user exists',
        () async {
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('testUserId');
      when(() => mockDocSnapshot.exists).thenReturn(true);
      when(() => mockDocRef.update(any())).thenAnswer((_) async {});

      final result = await repository.updateUserSubscriptionPackage(
          SubscriptionPackage.pro, null);

      expect(result.isRight, true);
      verify(() => mockDocRef.update({
            'subscriptionPackage': 'pro',
            'isFirstLogin': false,
            'canChangeSubscription': false,
          })).called(1);
    });

    test('should return failure when user does not exist', () async {
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('testUserId');
      when(() => mockDocSnapshot.exists).thenReturn(false);

      final result = await repository.updateUserSubscriptionPackage(
          SubscriptionPackage.pro, null);

      expect(result.isLeft, true);
      result.fold(
        (failure) {
          expect(failure, isA<Failure>());
          expect(failure.title, 'User not found');
        },
        (_) => fail('Expected Left, but got Right'),
      );
    });

    test('should use provided userId when available', () async {
      const providedUserId = 'providedUserId';
      when(() => mockDocSnapshot.exists).thenReturn(true);
      when(() => mockDocRef.update(any())).thenAnswer((_) async {});

      await repository.updateUserSubscriptionPackage(
          SubscriptionPackage.gold, providedUserId);

      verify(() => mockCollectionRef.doc(providedUserId)).called(1);
    });

    test('should use current user id when userId is not provided', () async {
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('currentUserId');
      when(() => mockDocSnapshot.exists).thenReturn(true);
      when(() => mockDocRef.update(any())).thenAnswer((_) async {});

      await repository.updateUserSubscriptionPackage(
          SubscriptionPackage.pro, null);

      verify(() => mockCollectionRef.doc('currentUserId')).called(1);
    });

    test('should handle Firebase exceptions', () async {
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('testUserId');
      when(() => mockDocSnapshot.exists).thenReturn(true);
      when(() => mockDocRef.update(any()))
          .thenThrow(FirebaseAuthException(code: 'test'));

      final result = await repository.updateUserSubscriptionPackage(
          SubscriptionPackage.pro, null);

      expect(result.isLeft, true);
      result.fold(
        (failure) => expect(failure, isA<Failure>()),
        (_) => fail('Expected Left, but got Right'),
      );
    });

    test('should handle general exceptions', () async {
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('testUserId');
      when(() => mockDocSnapshot.exists).thenReturn(true);
      when(() => mockDocRef.update(any()))
          .thenThrow(FirebaseAuthException(code: 'General error'));

      final result = await repository.updateUserSubscriptionPackage(
          SubscriptionPackage.pro, null);

      expect(result.isLeft, true);
      expect((result as Left).value, isA<Failure>());
    });
  });
}
