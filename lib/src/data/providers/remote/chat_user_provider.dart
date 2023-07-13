import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class ChatUserProvider {
  Future<bool> addChatUser({required String checkID});

  Future<void> removeChatUser({required String id});
}

@Injectable(as: ChatUserProvider)
class ChatUserProviderImpl implements ChatUserProvider {
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final _authUser = FirebaseAuth.instance.currentUser;

  @override
  Future<bool> addChatUser({required String checkID}) async {
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

  void _setSecondCollection({
    required User user,
    required QuerySnapshot<Map<String, dynamic>> data,
    required String textCollection,
  }) {
    _store
        .collection('users')
        .doc(user.uid)
        .collection(textCollection)
        .doc(data.docs.first.id)
        .set({});
  }

  @override
  Future<void> removeChatUser({required String id}) async {
    await _store
        .collection('users')
        .doc(_authUser?.uid)
        .collection('chat_users')
        .doc(id)
        .delete();
  }
}
