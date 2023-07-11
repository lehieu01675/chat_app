import 'dart:io';


import 'package:chatapp/src/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditingProfileRepository {
  UserModel? currentUser;
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final User? _authUser = FirebaseAuth.instance.currentUser;


  /// get current user
  Future<UserModel> getCurrentUser() async {
    try {
      final userId = _authUser?.uid;
      final user = await _store.collection('users').doc(userId).get();
      UserModel currentUser = UserModel.fromJson(user.data()!);
      return currentUser;
    } catch (e) {
      throw Exception(e);
    }
  }

  /// update avatar
  Future<void> updateAvatar(File file) async {
    final ext = file.path.split('.').last;
    final ref = _storage.ref().child('profile_pictures/${_authUser!.uid}.$ext');

    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {});

    var imageUrl = await ref.getDownloadURL();
    await _store
        .collection('users')
        .doc(_authUser!.uid)
        .update({'image': imageUrl});
  }

  /// update profile
  Future<void> updateProfile(
      {required String name,
      required String introduce,
      required String email,
      required String phoneNumber}) async {
    await _store.collection('users').doc(_authUser!.uid).update({
      'name': name,
      'about': introduce,
      'email': email,
      'phone_number': phoneNumber
    });
  }
}
