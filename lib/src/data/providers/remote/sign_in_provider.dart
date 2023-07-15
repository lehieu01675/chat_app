import 'package:chatapp/src/constant/text_cons.dart';
import 'package:chatapp/src/l10n/app_localizations.dart';
import 'package:chatapp/src/utils/app_context.dart';
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
      if (e.code == TextConstant.userNotFound) {
        throw Exception(
            AppLocalizations.of(AppContext.getContext()!)!.emailNotRegistered);
      } else if (e.code == TextConstant.wrongPassword) {
        throw Exception(
            AppLocalizations.of(AppContext.getContext()!)!.wrongPassword);
      } else {
        throw Exception("Unknown exception");
      }
    }
  }
}
