import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/data/providers/remote/user_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

abstract class UserRepository {
  Future<bool> checkUserExists();

  Future<void> createUser();

  Future<void> updateUserStatus({required bool status});

  Future<UserModel?> getCurrentUser();
}

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserProvider _userProvider = GetIt.I.get<UserProvider>();

  @override
  Future<bool> checkUserExists() async {
    return await _userProvider.checkUserExist();
  }

  @override
  Future<void> createUser() async {
    await _userProvider.createUser();
  }

  @override
  Future<void> updateUserStatus({required bool status}) async {
    await _userProvider.updateUserStatus(status: status);
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    return await _userProvider.getCurrentUser();
  }
}
