import 'package:chatapp/src/data/providers/remote/google_sign_in_provider.dart';
import 'package:chatapp/src/data/providers/remote/sign_in_provider.dart';

class SignInRepository {
  final SignInProvider _signInProvider = SignInProvider();
  final GoogleSignInProvider _googleSignInProvider = GoogleSignInProvider();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _signInProvider.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signInWithGoogle() async {
    await _googleSignInProvider.signInWithGoogle();
  }
}
