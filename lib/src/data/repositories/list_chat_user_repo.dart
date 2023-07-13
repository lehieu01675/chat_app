import 'dart:async';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListChatUserRepository {
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final _authUser = FirebaseAuth.instance.currentUser;

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _listenChatUsers;

  final StreamController<List<UserModel>> _streamChatUsers =
      StreamController.broadcast();

  Stream<List<UserModel>> get streamChatUsers => _streamChatUsers.stream;

  ListChatUserRepository() {
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
}
