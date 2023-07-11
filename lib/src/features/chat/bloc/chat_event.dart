part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

/// set first message
class ChatSendFirstMessage extends ChatEvent {
  final UserModel guestUser;
  final UserModel currentUser;
  final String message;
  final Type type;

  const ChatSendFirstMessage(
      this.guestUser, this.currentUser, this.message, this.type);
  @override
  List<Object> get props => [guestUser, currentUser, message, type];
}
/// send message
class ChatSendMessage extends ChatEvent {
  final UserModel guestUser;
  final UserModel currentUser;
  final String msg;
  final Type type;

  const ChatSendMessage(
      this.guestUser, this.currentUser, this.msg, this.type);
  @override
  List<Object> get props => [guestUser, currentUser, msg, type];
}
/// get list message
class ChatGetListMessage extends ChatEvent {
  final List<MessageModel> listMessage;

  const ChatGetListMessage({required this.listMessage});
  @override
  List<Object> get props => [listMessage];
}

/// send image message
class ChatSendImageMessage extends ChatEvent {
  final UserModel guestUser;
  final UserModel currentUser;
  final File file;

  const ChatSendImageMessage(
      {required this.currentUser, required this.guestUser, required this.file});
  @override
  List<Object> get props => [guestUser, currentUser, file];
}

/// delete message
class ChatDeleteMessage extends ChatEvent {
  final MessageModel message;

  const ChatDeleteMessage({required this.message});

  @override
  List<Object> get props => [message];
}
