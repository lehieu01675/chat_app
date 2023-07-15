import 'package:chatapp/src/data/providers/remote/sign_out_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

abstract class SignOutRepository {
  Future<void> signOut();
}

@Injectable(as: SignOutRepository)
class SignOutRepositoryImpl extends SignOutRepository {
  final SignOutProvider _signOutProvider = GetIt.I.get<SignOutProvider>();

  @override
  Future<void> signOut() async {
    await _signOutProvider.signOut();
  }
}
