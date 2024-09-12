import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:photopulse/common/data/firestore/firestore_collections.dart';
import 'package:photopulse/features/auth/domain/entities/user.dart';

class FirebaseWrapper {
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  User? get currentUser => firebaseAuth.currentUser;

  CollectionReference<PhotoPulseUser> get usersCollection =>
      FirestoreCollections.usersCollection;
}
