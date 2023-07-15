import 'dart:convert';
import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:chatapp/src/helper/text_helper.dart';
import 'package:chatapp/src/data/models/message_model.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallScreen extends StatefulWidget {
  final UserModel guestUser;
  final UserModel currentUser;
  final bool? isVideoCall;

  const CallScreen({
    super.key,
    required this.guestUser,
    required this.currentUser,
    required this.isVideoCall,
  });

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  int appIDVideoCall = 0;
  String appSignVideoCall = "";

  @override
  void initState() {
    super.initState();
    appIDVideoCall = int.parse(dotenv.get("APP_ID_VIDEO_CALL"));
    appSignVideoCall = dotenv.get("APP_SIGN_IN_VIDEO_CALL");

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
        currentUser: widget.currentUser,
        guestUser: widget.guestUser,
        title: widget.isVideoCall!
            ? ' ${widget.currentUser.name} is calling you'
            : ' ${widget.currentUser.name} is calling you');
  }

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: appIDVideoCall,
      appSign: appSignVideoCall,
      userID: widget.guestUser.checkId,
      userName: widget.currentUser.name,
      callID: _getConversationID(guestId: widget.guestUser.id),
      onDispose: () {
        sendMessage(
            guestUser: widget.guestUser,
            currentUser: widget.currentUser,
            msg: widget.isVideoCall! ? 'Video call ended' : 'Call ended',
            type: Type.text);
      },
      config: widget.isVideoCall!
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

  Future<void> pushMessageNotification(
      {required UserModel currentUser,
      required String title,
      required UserModel guestUser}) async {
    try {
      final body = {
        "to": guestUser.pushToken,
        "notification": {
          "title": title,
          //our name should be send
          "body": '${widget.currentUser.name} call',
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
}
