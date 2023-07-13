import 'package:chatapp/src/data/exceptions/sign_in_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class SignInProvider {
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}

@Injectable(as: SignInProvider)
class SignInProviderImpl implements SignInProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw SignInException('Email is not registered account');
      } else if (e.code == 'wrong-password') {
        throw SignInException(
            'Wrong password. Please check your password again');
      } else {
        throw Exception("Unknown exception");
      }
    }
  }
}
