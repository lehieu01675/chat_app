import 'dart:math';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

abstract class UserProvider {
  Future<UserModel?> getCurrentUser();

  Future<void> getFirebaseMessagingToken({required UserModel currentUser});

  Future<void> updateUserStatus({required bool status});

  Future<bool> checkUserExist();

  Future<void> createUser();
}

@Injectable(as: UserProvider)
class UserProviderImpl implements UserProvider {
  UserModel? currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      var userId = _auth.currentUser?.uid;
      var user = await _store.collection('users').doc(userId).get();
      currentUser = UserModel.fromJson(user.data()!);

      await getFirebaseMessagingToken(currentUser: currentUser!);
      return currentUser;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> getFirebaseMessagingToken({
    required UserModel currentUser,
  }) async {
    var user = _auth.currentUser;
    await _messaging.requestPermission();

    await _messaging.getToken().then((token) {
      if (token != null) {
        currentUser.pushToken = token;
        _updatePushToken(user, token);
      }
    });
  }

  void _updatePushToken(User? user, String token) {
    _store.collection('users').doc(user!.uid).update({'push_token': token});
  }

  @override
  Future<void> updateUserStatus({required bool status}) async {
    var user = _auth.currentUser;
    await _store.collection('users').doc(user!.uid).update({
      'is_online': status,
    });
  }

  @override
  Future<bool> checkUserExist() async {
    return (await _store.collection('users').doc(_auth.currentUser!.uid).get())
        .exists;
  }

  String _generateRandomString() {
    Random random = Random();
    String result = '';
    for (int i = 0; i < 6; i++) {
      result += random.nextInt(10).toString();
    }
    return result;
  }

  @override
  Future<void> createUser() async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    final chatUser = UserModel(
        listChatID: [],
        image:
            'https://firebasestorage.googleapis.com/v0/b/chat-app-c8403.appspot.com/o/photo_6271590531171728269_y.jpg?alt=media&token=bfdf2cb4-ecd7-4906-87dc-6df9d84a6b05',
        introduce: 'Introduce',
        name: 'Name',
        createdAt: time,
        lastActive: time,
        id: _auth.currentUser!.uid,
        isOnline: false,
        checkId: _generateRandomString(),
        email: '',
        gender: 'Không xác định',
        pushToken: '',
        phoneNumber: '');
    await _store
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .set(chatUser.toJson());
  }
}
