import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:photopulse/common/data/firestore/firestore_collections.dart';
import 'package:photopulse/features/auth/domain/entities/user.dart';

class FirebaseWrappers {
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  User? get currentUser => firebaseAuth.currentUser;

  CollectionReference<PhotoPulseUser> get usersCollection =>
      FirestoreCollections.usersCollection;
}
