import 'dart:io';

import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/data/providers/remote/message_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:chatapp/src/data/models/message_model.dart';

abstract class MessageRepository {
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

@Injectable(as: MessageRepository)
class MessageRepositoryImpl implements MessageRepository {
  final MessageProvider _messageProvider = GetIt.I.get<MessageProvider>();

  @override
  Future<void> sendFirstMessage({
    required UserModel guestUser,
    required UserModel currentUser,
    required String msg,
    required Type type,
  }) async {
    await _messageProvider.sendFirstMessage(
      guestUser: guestUser,
      currentUser: currentUser,
      msg: msg,
      type: type,
    );
  }

  @override
  Future<void> sendMessage({
    required UserModel guestUser,
    required UserModel currentUser,
    required String msg,
    required Type type,
  }) async {
    await _messageProvider.sendMessage(
      guestUser: guestUser,
      currentUser: currentUser,
      msg: msg,
      type: type,
    );
  }

  @override
  Future<void> pushMessageNotification({
    required UserModel currentUser,
    required UserModel guestUser,
    required String msg,
  }) async {
    await _messageProvider.pushMessageNotification(
      currentUser: currentUser,
      guestUser: guestUser,
      msg: msg,
    );
  }

  @override
  Future<void> sendImageMessage({
    required UserModel guestUser,
    required UserModel currentUser,
    required File file,
  }) async =>
      await _messageProvider.sendImageMessage(
        guestUser: guestUser,
        currentUser: currentUser,
        file: file,
      );

  @override
  String getConversationID({required String guestId}) {
    return _messageProvider.getConversationID(guestId: guestId);
  }

  @override
  Future<void> deleteMessage({required MessageModel message}) async {
    await _messageProvider.deleteMessage(message: message);
  }
}
