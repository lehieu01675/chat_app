import 'package:chatapp/src/data/providers/remote/google_sign_in_provider.dart';
import 'package:chatapp/src/data/providers/remote/sign_in_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

abstract class SignInRepository {
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signInWithGoogle();
}

@Injectable(as: SignInRepository)
class SignInRepositoryImpl implements SignInRepository {
  final SignInProvider _signInProvider = GetIt.I.get<SignInProvider>();
  final GoogleSignInProvider _googleSignInProvider =
      GetIt.I.get<GoogleSignInProvider>();

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _signInProvider.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signInWithGoogle() async {
    await _googleSignInProvider.signInWithGoogle();
  }
}
