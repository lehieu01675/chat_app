import 'package:firebase_auth/firebase_auth.dart';

class SignInProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('Email is not registered account');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password. Please check your password again');
      }
    }
  }
}
