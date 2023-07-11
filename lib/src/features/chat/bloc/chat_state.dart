part of 'chat_bloc.dart';

enum ChatStatus {
  initial,
  loading,
  success,
  failure,
  imageLoading,
  imageSuccess,
  imageFailure
}

class ChatState extends Equatable {
  final ChatStatus status;
  final List<MessageModel> listMessage;

  const ChatState({required this.status, required this.listMessage});

  @override
  List<Object> get props => [status, listMessage];
}
