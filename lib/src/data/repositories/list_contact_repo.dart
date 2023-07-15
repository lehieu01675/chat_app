import 'dart:async';

import 'package:chatapp/src/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class ListContactRepository {
  Stream<List<UserModel>> get streamContactUser;

  void close();
}

@Injectable(as: ListContactRepository)
class ListContactRepositoryImpl implements ListContactRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _listenContactUser;

  final StreamController<List<UserModel>> _streamContactUser =
      StreamController.broadcast();

  @override
  Stream<List<UserModel>> get streamContactUser => _streamContactUser.stream;

  ListContactRepositoryImpl() {
    final user = _auth.currentUser;
    _listenContactUser = _store
        .collection('users')
        .doc(user!.uid)
        .collection('contacts')
        .snapshots()
        .listen((chatIdSnapshot) async {
      List<UserModel> listChatUser = await _loadRawData(chatIdSnapshot);
      _streamContactUser.add(listChatUser);
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

  @override
  void close() {
    _listenContactUser?.cancel();
    _streamContactUser.close();
  }
}
