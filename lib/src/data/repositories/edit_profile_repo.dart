import 'dart:io';
import 'package:chatapp/src/data/providers/remote/edit_profile_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

abstract class EditProfileRepository {
  Future<void> updateAvatar({required File imageFile});

  Future<void> updateProfile({
    required String name,
    required String introduce,
    required String email,
    required String phoneNumber,
  });
}

@Injectable(as: EditProfileRepository)
class EditProfileRepositoryImpl implements EditProfileRepository {
  final EditProfileProvider _editProfileProvider =
      GetIt.I.get<EditProfileProvider>();

  @override
  Future<void> updateAvatar({required File imageFile}) async {
    await _editProfileProvider.updateAvatar(imageFile: imageFile);
  }

  @override
  Future<void> updateProfile({
    required String name,
    required String introduce,
    required String email,
    required String phoneNumber,
  }) async {
    await _editProfileProvider.updateProfile(
      name: name,
      introduce: introduce,
      email: email,
      phoneNumber: phoneNumber,
    );
  }
}
