import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {

  late GoogleSignIn  google;

AuthRepository(){
  google = GoogleSignIn();
}

  Future<User?> getUserSign() {
    return FirebaseAuth.instance.authStateChanges().first;
  }

  Future<UserCredential?> signInGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await google.signIn();

    if (googleUser != null) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await google.signOut();
  }
}
