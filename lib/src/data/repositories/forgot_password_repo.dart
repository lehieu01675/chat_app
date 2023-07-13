import 'package:chatapp/src/data/providers/remote/forgot_password_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

abstract class ForgotPasswordRepository {
  Future<void> forgotPassword({required String email});
}

@Injectable(as: ForgotPasswordRepository)
class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final ForgotPasswordProvider _passwordProvider =
      GetIt.I.get<ForgotPasswordProvider>();

  @override
  Future<void> forgotPassword({required String email}) async {
    await _passwordProvider.forgotPassword(email: email);
  }
}
