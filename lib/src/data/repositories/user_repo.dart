import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/data/providers/remote/user_provider.dart';

class UserRepository {
  final UserProvider _userProvider = UserProvider();

  Future<bool> checkUserExists() async {
    return await _userProvider.checkUserExist();
  }

  Future<void> createUser() async {
    await _userProvider.createUser();
  }

  Future<void> updateUserStatus({required bool status}) async {
    await _userProvider.updateUserStatus(status: status);
  }

  Future<UserModel?> getCurrentUser() async {
    return await _userProvider.getCurrentUser();
  }
}
