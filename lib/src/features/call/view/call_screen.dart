import 'dart:convert';
import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chatapp/src/constant/text_cons.dart';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:chatapp/src/data/models/message_model.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatefulWidget {
  final bool isVideoCall;

  const CallPage({
    super.key,
    required this.isVideoCall,
  });

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  late UserModel currentUser;
  late UserModel guestUser;
  final _currentUserCache = Hive.box(TextConstant.currentUserPath);

  int appIDVideoCall = 0;
  String appSignVideoCall = "";

  @override
  void initState() {
    super.initState();
    appIDVideoCall = int.parse(dotenv.get("APP_ID_VIDEO_CALL"));
    appSignVideoCall = dotenv.get("APP_SIGN_IN_VIDEO_CALL");
    currentUser = _currentUserCache.get('user');
    guestUser = _currentUserCache.get('guest_user');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String? title = message.notification!.title;
      String? body = message.notification!.body;
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 123,
          channelKey: "call_channel",
          color: Colors.white,
          title: title,
          body: body,
          category: NotificationCategory.Call,
          wakeUpScreen: true,
          fullScreenIntent: true,
          autoDismissible: false,
          backgroundColor: Colors.orange,
        ),
      );
    });

    pushMessageNotification(
        currentUser: currentUser,
        guestUser: guestUser,
        title: widget.isVideoCall
            ? ' ${currentUser.name} is calling you'
            : ' ${currentUser.name} is calling you');
  }

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: appIDVideoCall,
      appSign: appSignVideoCall,
      userID: guestUser.checkId,
      userName: currentUser.name,
      callID: _getConversationID(guestId: guestUser.id),
      onDispose: () {
        sendMessage(
            guestUser: guestUser,
            currentUser: currentUser,
            msg: widget.isVideoCall ? 'Video call ended' : 'Call ended',
            type: Type.text);
      },
      config: widget.isVideoCall
          ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
          : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    );
  }

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
        'chats/${_getConversationID(guestId: guestUser.id)}/messages/');
    await ref.doc(time).set(message.toJson());

    // create lass_message collection
    final lastMessageRef = _store.collection(
        'chats/${_getConversationID(guestId: guestUser.id)}/last_message');
    await lastMessageRef.doc('message').set(message.toJson());
  }

  String _getConversationID({required String guestId}) {
    var user = _auth.currentUser;

    return user!.uid.hashCode <= guestId.hashCode
        ? '${user.uid}_$guestId'
        : '${guestId}_${user.uid}';
  }

  Future<void> pushMessageNotification({
    required UserModel currentUser,
    required String title,
    required UserModel guestUser,
  }) async {
    try {
      final body = {
        "to": guestUser.pushToken,
        "notification": {
          "title": title,
          //our name should be send
          "body": '${currentUser.name} call',
          "android_channel_id": "chats"
        },
      };
      final serviceKeyForNotification = dotenv.get("SERVICE_KEY_NOTIFICATION");
      await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'key=$serviceKeyForNotification'
          },
          body: jsonEncode(body));
    } catch (e) {
      throw Exception(e);
    }
  }
}
