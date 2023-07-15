import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

abstract class SignOutProvider {
  Future<void> signOut();
}

@Injectable(as: SignOutProvider)
class SignOutProviderImpl implements SignOutProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await GoogleSignIn().signOut();
    } catch (e) {
      throw Exception('Sign out failed');
    }
  }
}
