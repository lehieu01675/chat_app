import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatUserProvider {
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final _authUser = FirebaseAuth.instance.currentUser;

  Future<bool> addChatUser(String checkID) async {
    final data = await _store
        .collection('users')
        .where('check_id', isEqualTo: checkID)
        .get();
    if (data.docs.isNotEmpty && data.docs.first.id != _authUser!.uid) {
      _setSecondCollection(
          user: _authUser!, data: data, textCollection: 'chat_users');
      _setSecondCollection(
          user: _authUser!, data: data, textCollection: 'contacts');
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

  Future<void> removeChatUser({required String id}) async {
    await _store
        .collection('users')
        .doc(_authUser?.uid)
        .collection('chat_users')
        .doc(id)
        .delete();
  }
}
