import 'dart:async';
import 'dart:io';

import 'package:chatapp/src/data/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatapp/src/features/chat/repositories/chat_repo.dart';

import 'package:chatapp/src/models/message_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatRepository chatRepository;
  StreamSubscription<List<MessageModel>>? _subscriptionMessage;
  ChatBloc({required this.chatRepository})
      : super(const ChatState(
            listMessage: [], status: ChatStatus.initial)) {
    ////
    on<ChatSendFirstMessage>(_sendFirstMessage);
    on<ChatSendMessage>(_sendMessage);
    on<ChatGetListMessage>(_getListMessage);
    on<ChatSendImageMessage>(_sendImageMessage);
    on<ChatDeleteMessage>(_deleteMessage);

    // listen Chat from firebase
    _subscriptionMessage = chatRepository.streamMessage.listen((event) {
      add(ChatGetListMessage(listMessage: event));
    });
  }

  /// send image message
  Future<void> _sendImageMessage(
      ChatSendImageMessage event, Emitter<ChatState> emit) async {
    try {
      emit(ChatState(
          status: ChatStatus.imageLoading, listMessage: state.listMessage));
      await chatRepository.sendImageMessage(
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

  /// delete message
  Future<void> _deleteMessage(
      ChatDeleteMessage event, Emitter<ChatState> emit) async {
    try {
      await chatRepository.deleteMessage(event.message);
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
  /// send first message
  Future<void> _sendFirstMessage(
      ChatSendFirstMessage event, Emitter<ChatState> emit) async {
    try {
      await chatRepository.sendFirstMessage(
          guestUser: event.guestUser,
          currentUser: event.currentUser,
          msg: event.message,
          type: event.type);
    } catch (e) {
      throw Exception(e);
    }
  }

  /// send message
  Future<void> _sendMessage(
      ChatSendMessage event, Emitter<ChatState> emit) async {
    try {
      await chatRepository.sendMessage(
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
    chatRepository.close();
    return super.close();
  }
}
