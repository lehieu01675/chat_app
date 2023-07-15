import 'dart:async';

import 'package:chatapp/src/data/models/message_model.dart';
import 'package:chatapp/src/data/providers/remote/message_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

abstract class ListMessageRepository {
  static String? conversationId;

  Stream<List<MessageModel>> get streamMessage;

  void close();
}

@Injectable(as: ListMessageRepository)
class ListMessageRepositoryImpl implements ListMessageRepository {
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final MessageProvider _messageProvider = GetIt.I.get<MessageProvider>();
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _listenMessage;
  final StreamController<List<MessageModel>> _streamMessage =
      StreamController.broadcast();

  ListMessageRepositoryImpl() {
    _listenMessage = _store
        .collection('chats')
        .doc(_messageProvider.getConversationID(
            guestId: ListMessageRepository.conversationId!))
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

  @override
  void close() {
    _listenMessage?.cancel();
    _streamMessage.close();
  }

  @override
  Stream<List<MessageModel>> get streamMessage => _streamMessage.stream;
}
