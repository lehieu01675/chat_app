import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class ForgotPasswordProvider {
  Future<void> forgotPassword({required String email});
}

@Injectable(as: ForgotPasswordProvider)
class ForgotPasswordProviderImpl implements ForgotPasswordProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }
}
