import 'package:chatapp/src/data/providers/remote/google_sign_in_provider.dart';
import 'package:chatapp/src/data/providers/remote/sign_up_provider.dart';

class SignUpRepository {
  final SignUpProvider _signUpProvider = SignUpProvider();
  final GoogleSignInProvider _googleSignInProvider = GoogleSignInProvider();

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _signUpProvider.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signInWithGoogle() async {
    await _googleSignInProvider.signInWithGoogle();
  }
}
