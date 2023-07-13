import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

abstract class GoogleSignInProvider {
  Future<void> signInWithGoogle();
}

@Injectable(as: GoogleSignInProvider)
class GoogleSignInProviderImpl implements GoogleSignInProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
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
