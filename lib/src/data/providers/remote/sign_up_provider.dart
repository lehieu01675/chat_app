import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class SignUpProvider {
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });
}

@Injectable(as: SignUpProvider)
class SignUpProviderImpl implements SignUpProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('Password is too weak');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('This email has been registered. Please log in');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
