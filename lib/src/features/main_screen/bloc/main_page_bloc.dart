import 'dart:async';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/data/repositories/chat_user_repository.dart';
import 'package:chatapp/src/data/repositories/list_chat_user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'main_page_event.dart';

part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainScreenEvent, MainScreenState> {
  ListChatUserRepository listChatUserRepository =
      GetIt.I.get<ListChatUserRepository>();
  ChatUserRepository chatUserRepository = GetIt.I.get<ChatUserRepository>();
  StreamSubscription<List<UserModel>>? _subscriptionChatUsers;

  MainPageBloc() : super(MainScreenLoading()) {
    on<MainScreenGetListChatUser>(_getListChatUser);
    on<MainScreenAddChatUser>(_addNewChatUser);
    on<MainScreenRemoveChatUser>(_removeChatUser);
    _subscriptionChatUsers =
        listChatUserRepository.streamChatUsers.listen((event) {
      add(MainScreenGetListChatUser(listChatUser: event));
    });
  }

  /// after listen data from firebase -> event -> state
  FutureOr<void> _getListChatUser(
      MainScreenGetListChatUser event, Emitter<MainScreenState> emit) async {
    try {
      emit(MainScreenGetListChatUserSuccess(listChatUser: event.listChatUser));
    } catch (e) {
      emit(MainScreenError(error: e.toString()));
    }
  }

  Future<void> _addNewChatUser(
      MainScreenAddChatUser event, Emitter<MainScreenState> emit) async {
    try {
      await chatUserRepository.addChatUser(checkID: event.checkId);
    } catch (e) {
      emit(MainScreenError(error: e.toString()));
    }
  }

  Future<void> _removeChatUser(
      MainScreenRemoveChatUser event, Emitter<MainScreenState> emit) async {
    try {
      await chatUserRepository.removeChatUser(id: event.id);
    } catch (e) {
      emit(MainScreenError(error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscriptionChatUsers?.cancel();
    listChatUserRepository.close();
    return super.close();
  }
}
