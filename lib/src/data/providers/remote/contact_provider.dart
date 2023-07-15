import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class ContactProvider {
  Future<void> deleteContactUser({required String id});
  Future<bool> addChatUser({required String checkID});
}

@Injectable(as: ContactProvider)
class ContactProviderImpl implements ContactProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  @override
  Future<void> deleteContactUser({required String id}) async {
    var user = _auth.currentUser;
    await _deleteSecondCollection(user, id, 'contacts');
    await _deleteSecondCollection(user, id, 'chat_users');
  }

  Future<void> _deleteSecondCollection(
    User? user,
    String id,
    String textCollection,
  ) async {
    await _store
        .collection('users')
        .doc(user!.uid)
        .collection(textCollection)
        .doc(id)
        .delete();
  }

  @override
  Future<bool> addChatUser({required String checkID}) async {
    var user = _auth.currentUser;
    final data = await _store
        .collection('users')
        .where('check_id', isEqualTo: checkID)
        .get();
    if (data.docs.isNotEmpty && data.docs.first.id != user!.uid) {
      _store
          .collection('users')
          .doc(user.uid)
          .collection('chat_users')
          .doc(data.docs.first.id)
          .set({});

      return true;
    } else {
      return false;
    }
  }
}
