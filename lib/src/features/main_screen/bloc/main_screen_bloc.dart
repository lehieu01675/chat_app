import 'dart:async';

import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/features/main_screen/repositories/main_screen_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenRepository mainScreenRepository;
  StreamSubscription<List<UserModel>>? _subscriptionChatUsers;

  MainScreenBloc({required this.mainScreenRepository})
      : super(MainScreenLoading()) {
    on<MainScreenGetListChatUser>(_getListChatUser);
    on<MainScreenAddChatUser>(_addNewChatUser);
    on<MainScreenDeleteChatUser>(_deleteChatUser);

    /// listen changes on firebase to add event
    _subscriptionChatUsers =
        mainScreenRepository.streamChatUsers.listen((event) {
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

  /// add new chat user
  Future<void> _addNewChatUser(
      MainScreenAddChatUser event, Emitter<MainScreenState> emit) async {
    try {
      await mainScreenRepository.addChatUser(event.checkId);
      //result ? emit(MainScreenAddMainScreenUserSuccessed()) : null;
    } catch (e) {
      emit(MainScreenError(error: e.toString()));
    }
  }

  /// delte chat user
  Future<void> _deleteChatUser(
      MainScreenDeleteChatUser event, Emitter<MainScreenState> emit) async {
    try {
      await mainScreenRepository.deleteChatUser(id: event.id);
    } catch (e) {
      emit(MainScreenError(error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscriptionChatUsers?.cancel();
    mainScreenRepository.close();
    return super.close();
  }
}
