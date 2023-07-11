import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';
import 'package:chatapp/src/helper/text_helper.dart';

import 'package:chatapp/src/models/message_model.dart';

class ChatRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _listenMessage;
  final StreamController<List<MessageModel>> _streamMessage =
  StreamController.broadcast();

  Stream<List<MessageModel>> get streamMessage => _streamMessage.stream;

  static String? conversationId;

  // hash
  ChatRepository() {
    _listenMessage = _store
        .collection('chats')
        .doc(getConversationID(guestId: conversationId!))
        .collection('messages/')
        .orderBy('sent', descending: true)
        .snapshots()
        .listen((messageSnapshot) async {
      List<MessageModel> listMessage = _loadRawData(messageSnapshot);
      _streamMessage.add(listMessage);
    });
  }

  List<MessageModel> _loadRawData(
      QuerySnapshot<Map<String, dynamic>> messageSnapshot) {
    final listMessage = messageSnapshot.docs
        .map((doc) => MessageModel.fromJson(doc.data()))
        .toList();
    return listMessage;
  }

  void close() {
    _listenMessage?.cancel();
    _streamMessage.close();
  }

  Future<void> sendFirstMessage({required UserModel guestUser,
    required UserModel currentUser,
    required String msg,
    required Type type}) async {
    final user = _auth.currentUser;
    await _store
        .collection('users')
        .doc(guestUser.id)
        .collection('chat_users')
        .doc(user!.uid)
        .set({}).then((value) =>
        sendMessage(
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
    for(String s in listChatID) {
      if(s == getConversationID(guestId: guestUser.id)) {
        listChatID.remove(s);
      }
    }
    listChatID.add(getConversationID(guestId: guestUser.id));
    _store.collection('users').doc(currentUser.id).update({'listChatID': listChatID});

  } // hashcode

  Future<void> sendMessage(
      {required UserModel guestUser,
      required UserModel currentUser,
      required String msg,
      required Type type}) async {
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

  // get conversation'id
  String getConversationID({required String guestId}) {
    var user = _auth.currentUser;
    // because conversationId is make from guestId and currentId but
    // so we have to make the same conversationId between 2 user
    return user!.uid.hashCode <= guestId.hashCode
        ? '${user.uid}_$guestId'
        : '${guestId}_${user.uid}';
  }

  Future<void> pushMessageNotification(
      {required UserModel currentUser,
      required UserModel guestUser,
      required String msg}) async {
    try {
      final body = {
        "to": guestUser.pushToken,
        "notification": {
          "title": 'New message from ${currentUser.name}', //our name should be send
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

  Future<void> sendImageMessage(
      {required UserModel guestUser,
      required UserModel currentUser,
      required File file}) async {
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

  // delete message
  Future<void> deleteMessage(MessageModel message) async {
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
