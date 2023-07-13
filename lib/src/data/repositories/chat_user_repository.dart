import 'package:chatapp/src/data/providers/remote/chat_user_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

abstract class ChatUserRepository {
  Future<bool> addChatUser({required String checkID});

  Future<void> removeChatUser({required String id});
}

@Injectable(as: ChatUserRepository)
class ChatUserRepositoryImpl implements ChatUserRepository {
  final ChatUserProvider _chatUserProvider = GetIt.I.get<ChatUserProvider>();

  @override
  Future<bool> addChatUser({required String checkID}) async {
    return await _chatUserProvider.addChatUser(checkID: checkID);
  }

  @override
  Future<void> removeChatUser({required String id}) async {
    await _chatUserProvider.removeChatUser(id: id);
  }
}
