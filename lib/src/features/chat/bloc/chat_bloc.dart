import 'dart:async';
import 'dart:io';

import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/data/repositories/list_message_repo.dart';
import 'package:chatapp/src/data/repositories/message_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatapp/src/data/models/message_model.dart';
import 'package:get_it/get_it.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ListMessageRepository listMessageRepository =
      GetIt.I.get<ListMessageRepository>();
  MessageRepository messageRepository = GetIt.I.get<MessageRepository>();
  StreamSubscription<List<MessageModel>>? _subscriptionMessage;

  ChatBloc()
      : super(const ChatState(
          listMessage: [],
          status: ChatStatus.initial,
        )) {
    on<ChatSendFirstMessage>(_sendFirstMessage);
    on<ChatSendMessage>(_sendMessage);
    on<ChatGetListMessage>(_getListMessage);
    on<ChatSendImageMessage>(_sendImageMessage);
    on<ChatDeleteMessage>(_deleteMessage);

    // listen Chat from firebase
    _subscriptionMessage = listMessageRepository.streamMessage.listen((event) {
      add(ChatGetListMessage(listMessage: event));
    });
  }
  Future<void> _sendImageMessage(
      ChatSendImageMessage event, Emitter<ChatState> emit) async {
    try {
      emit(ChatState(
          status: ChatStatus.imageLoading, listMessage: state.listMessage));
      await messageRepository.sendImageMessage(
          guestUser: event.guestUser,
          currentUser: event.currentUser,
          file: event.file);

      emit(ChatState(
          status: ChatStatus.imageSuccess, listMessage: state.listMessage));
    } catch (e) {
      emit(ChatState(
          status: ChatStatus.imageFailure, listMessage: state.listMessage));
    }
  }

  Future<void> _deleteMessage(
      ChatDeleteMessage event, Emitter<ChatState> emit) async {
    try {
      await messageRepository.deleteMessage(message: event.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  /// get list message
  FutureOr<void> _getListMessage(
      ChatGetListMessage event, Emitter<ChatState> emit) async {
    try {
      emit(const ChatState(status: ChatStatus.loading, listMessage: []));
      emit(ChatState(
          status: ChatStatus.success, listMessage: event.listMessage));
    } catch (e) {
      emit(ChatState(
          status: ChatStatus.failure, listMessage: event.listMessage));
    }
  }

  Future<void> _sendFirstMessage(
      ChatSendFirstMessage event, Emitter<ChatState> emit) async {
    try {
      await messageRepository.sendFirstMessage(
          guestUser: event.guestUser,
          currentUser: event.currentUser,
          msg: event.message,
          type: event.type);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _sendMessage(
      ChatSendMessage event, Emitter<ChatState> emit) async {
    try {
      await messageRepository.sendMessage(
          guestUser: event.guestUser,
          currentUser: event.currentUser,
          msg: event.msg,
          type: event.type);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> close() {
    _subscriptionMessage?.cancel();
    listMessageRepository.close();
    return super.close();
  }
}
