import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Settings/firebase_options.dart';
import 'package:flutter/foundation.dart' show TargetPlatform;

class AuthService {
  GoogleSignIn googleSignIn() {
    // if currentPlatform is either ios and macos, then need to specify the clientId
    if (TargetPlatform.iOS == TargetPlatform.iOS ||
        TargetPlatform.macOS == TargetPlatform.macOS) {
      return GoogleSignIn(
          clientId: DefaultFirebaseOptions.currentPlatform.iosClientId);
    } else {
      return GoogleSignIn();
    }
  }

  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signOut() async {
    await googleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  getCurrentUserEmail() {
    return FirebaseAuth.instance.currentUser!.email;
  }
}
