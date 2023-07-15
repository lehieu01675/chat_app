import 'dart:convert';
import 'dart:io';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/helper/text_helper.dart';
import 'package:chatapp/src/data/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

abstract class MessageProvider {
  Future<void> sendFirstMessage({
    required UserModel guestUser,
    required UserModel currentUser,
    required String msg,
    required Type type,
  });

  String getConversationID({required String guestId});

  Future<void> sendMessage({
    required UserModel guestUser,
    required UserModel currentUser,
    required String msg,
    required Type type,
  });

  Future<void> pushMessageNotification({
    required UserModel currentUser,
    required UserModel guestUser,
    required String msg,
  });

  Future<void> sendImageMessage({
    required UserModel guestUser,
    required UserModel currentUser,
    required File file,
  });

  Future<void> deleteMessage({required MessageModel message});
}

@Injectable(as: MessageProvider)
class MessageProviderImpl implements MessageProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<void> sendFirstMessage({
    required UserModel guestUser,
    required UserModel currentUser,
    required String msg,
    required Type type,
  }) async {
    final user = _auth.currentUser;
    await _store
        .collection('users')
        .doc(guestUser.id)
        .collection('chat_users')
        .doc(user!.uid)
        .set({}).then((value) => sendMessage(
            guestUser: guestUser,
            msg: msg,
            type: type,
            currentUser: currentUser));

    _store
        .collection('users')
        .doc(guestUser.id)
        .collection('contacts')
        .doc(currentUser.id)
        .set({});

    List<String> listChatID = currentUser.listChatID;
    for (String s in listChatID) {
      if (s == getConversationID(guestId: guestUser.id)) {
        listChatID.remove(s);
      }
    }
    listChatID.add(getConversationID(guestId: guestUser.id));
    _store
        .collection('users')
        .doc(currentUser.id)
        .update({'listChatID': listChatID});
  }

  @override
  Future<void> sendMessage({
    required UserModel guestUser,
    required UserModel currentUser,
    required String msg,
    required Type type,
  }) async {
    final user = _auth.currentUser;
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final MessageModel message = MessageModel(
        toId: guestUser.id,
        msg: msg,
        read: '',
        type: type,
        fromId: user!.uid,
        sent: time);

    // create message with document is the time of message
    final ref = _store.collection(
        'chats/${getConversationID(guestId: guestUser.id)}/messages/');
    await ref.doc(time).set(message.toJson());

    // create lass_message collection
    final lastMessageRef = _store.collection(
        'chats/${getConversationID(guestId: guestUser.id)}/last_message');
    await lastMessageRef.doc('message').set(message.toJson());

    // push notification to guestMessage
    await ref.doc(time).set(message.toJson()).then((value) =>
        pushMessageNotification(
            currentUser: currentUser, guestUser: guestUser, msg: msg));
  }

  @override
  String getConversationID({required String guestId}) {
    var user = _auth.currentUser;
    // because conversationId is make from guestId and currentId but
    // so we have to make the same conversationId between 2 user
    return user!.uid.hashCode <= guestId.hashCode
        ? '${user.uid}_$guestId'
        : '${guestId}_${user.uid}';
  }

  @override
  Future<void> pushMessageNotification({
    required UserModel currentUser,
    required UserModel guestUser,
    required String msg,
  }) async {
    try {
      final body = {
        "to": guestUser.pushToken,
        "notification": {
          "title":
              'New message from ${currentUser.name}', //our name should be send
          "body": msg,
          "android_channel_id": "chats"
        },
      };

      await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'key=${TextHelper.serviceKeyForNotification}'
          },
          body: jsonEncode(body));
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> sendImageMessage({
    required UserModel guestUser,
    required UserModel currentUser,
    required File file,
  }) async {
    //getting image file extension
    final ext = file.path.split('.').last;

    //storage file ref with path
    final ref = _storage.ref().child(
        'images/${getConversationID(guestId: guestUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {});

    //updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(
        currentUser: currentUser,
        guestUser: guestUser,
        msg: imageUrl,
        type: Type.image);
  }

  @override
  Future<void> deleteMessage({required MessageModel message}) async {
    await _store
        .collection(
            'chats/${getConversationID(guestId: message.toId)}/messages/')
        .doc(message.sent)
        .delete();

    if (message.type == Type.image) {
      await _storage.refFromURL(message.msg).delete();
    }
  }
}
