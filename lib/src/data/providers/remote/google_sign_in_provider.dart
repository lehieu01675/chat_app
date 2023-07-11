import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _auth.signInWithCredential(credential);
    } catch (e) {
      throw Exception('Sign in with Google failed');
    }
  }
}