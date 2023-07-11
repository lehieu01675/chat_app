import 'dart:async';

import 'package:chatapp/src/data/models/user_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainScreenRepository {
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final _authUser = FirebaseAuth.instance.currentUser;

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _listenChatUsers;

  final StreamController<List<UserModel>> _streamChatUsers =
      StreamController.broadcast();

  Stream<List<UserModel>> get streamChatUsers => _streamChatUsers.stream;

  MainScreenRepository() {
    _listenChatUsers = _store
        .collection('users')
        .doc(_authUser?.uid)
        .collection('chat_users')
        .snapshots()
        .listen((chatIdSnapshot) async {
      List<UserModel> listChatUser = await _loadRawData(chatIdSnapshot);
      _streamChatUsers.add(listChatUser);
    });
  }

  Future<List<UserModel>> _loadRawData(
      QuerySnapshot<Map<String, dynamic>> chatIdSnapshot) async {
    final listChatId = chatIdSnapshot.docs.map((doc) => doc.id).toList();
    final chatUserSnapshot = await _store
        .collection('users')
        .where('id', whereIn: listChatId.isEmpty ? [''] : listChatId)
        .get();
    final listChatUser = chatUserSnapshot.docs
        .map((doc) => UserModel.fromJson(doc.data()))
        .toList();
    return listChatUser;
  }

  void close() {
    _listenChatUsers?.cancel();
    _streamChatUsers.close();
  }

  // add id of another user to chat_users collection
  Future<bool> addChatUser(String checkID) async {
    final data = await _store
        .collection('users')
        .where('check_id', isEqualTo: checkID)
        .get();
    if (data.docs.isNotEmpty && data.docs.first.id != _authUser!.uid) {
      _setSecondCollection(
          user: _authUser!, data: data, textCollection: 'chat_users');
      _setSecondCollection(user: _authUser!, data: data, textCollection: 'contacts');
   
      return true;
    } else {
      return false;
    }
  }

  void _setSecondCollection(
      {required User user,
      required QuerySnapshot<Map<String, dynamic>> data,
      required String textCollection}) {
    _store
        .collection('users')
        .doc(user.uid)
        .collection(textCollection)
        .doc(data.docs.first.id)
        .set({});
  }

  Future<void> deleteChatUser({required String id}) async {
    await _store
        .collection('users')
        .doc(_authUser?.uid)
        .collection('chat_users')
        .doc(id)
        .delete();
  }
}
