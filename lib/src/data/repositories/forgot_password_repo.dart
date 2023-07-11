import 'package:chatapp/src/data/providers/remote/forgot_password_provider.dart';

class ForgotPasswordRepository {
  final ForgotPasswordProvider _passwordProvider = ForgotPasswordProvider();

  Future<void> forgotPassword({required String email}) async {
    await _passwordProvider.forgotPassword(email: email);
  }
}
