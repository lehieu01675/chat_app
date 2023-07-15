import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

abstract class EditProfileProvider {
  Future<void> updateAvatar({required File imageFile});
  Future<void> updateProfile({
    required String name,
    required String introduce,
    required String email,
    required String phoneNumber,
  });
}

@Injectable(as: EditProfileProvider)
class EditProfileProviderImpl implements EditProfileProvider {
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final User? _authUser = FirebaseAuth.instance.currentUser;

  @override
  Future<void> updateAvatar({required File imageFile}) async {
    final ext = imageFile.path.split('.').last;
    final ref = _storage.ref().child('profile_pictures/${_authUser!.uid}.$ext');

    await ref
        .putFile(imageFile, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {});

    var imageUrl = await ref.getDownloadURL();
    await _store
        .collection('users')
        .doc(_authUser!.uid)
        .update({'image': imageUrl});
  }

  @override
  Future<void> updateProfile({
    required String name,
    required String introduce,
    required String email,
    required String phoneNumber,
  }) async {
    await _store.collection('users').doc(_authUser!.uid).update({
      'name': name,
      'about': introduce,
      'email': email,
      'phone_number': phoneNumber
    });
  }
}
