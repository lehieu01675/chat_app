import 'package:chatapp/src/data/providers/remote/chat_user_provider.dart';

class ChatUserRepository {
  final ChatUserProvider _chatUserProvider = ChatUserProvider();

  Future<bool> addChatUser({required String chatId}) async {
    return await _chatUserProvider.addChatUser(chatId);
  }

  Future<void> removeChatUser({required String id}) async {
    await _chatUserProvider.removeChatUser(id: id);
  }
}
