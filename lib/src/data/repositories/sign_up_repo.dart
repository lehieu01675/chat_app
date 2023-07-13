import 'package:chatapp/src/data/providers/remote/google_sign_in_provider.dart';
import 'package:chatapp/src/data/providers/remote/sign_up_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

abstract class SignUpRepository {
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signInWithGoogle();
}

@Injectable(as: SignUpRepository)
class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpProvider _signUpProvider = GetIt.I.get<SignUpProvider>();
  final GoogleSignInProvider _googleSignInProvider =
      GetIt.I.get<GoogleSignInProvider>();

  @override
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _signUpProvider.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signInWithGoogle() async {
    await _googleSignInProvider.signInWithGoogle();
  }
}
