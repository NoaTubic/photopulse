import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleWrapper {
  Future<GoogleSignInAccount?> signIn() async {
    return GoogleSignIn().signIn();
  }

  Future<OAuthCredential> getGoogleAuthCredential(
    GoogleSignInAuthentication googleAuth,
  ) async {
    return GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
  }
}
