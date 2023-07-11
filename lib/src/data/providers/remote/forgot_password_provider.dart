import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> forgotPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }
}
