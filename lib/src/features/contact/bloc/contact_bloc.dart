import 'dart:async';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/data/repositories/contact_repo.dart';
import 'package:chatapp/src/data/repositories/list_contact_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'contact_event.dart';

part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ListContactRepository listContactRepository =
      GetIt.I.get<ListContactRepository>();
  ContactRepository contactRepository = GetIt.I.get<ContactRepository>();
  StreamSubscription<List<UserModel>>? _subscription;

  ContactBloc() : super(ContactLoading()) {
    on<ContactLoadChatUsersEvent>(_loadContactUser);
    on<ContactDeleteContactUserEvent>(_deleteContactUser);
    on<ContactAddContactUserEvent>(_addChatUser);

    _subscription = listContactRepository.streamContactUser.listen((event) {
      add(ContactLoadChatUsersEvent(listContactUser: event));
    });
  }

  FutureOr<void> _loadContactUser(
      ContactLoadChatUsersEvent event, Emitter<ContactState> emit) async {
    try {
      emit(ContactLoadChatUserSuccess(listContactUser: event.listContactUser));
    } catch (e) {
      emit(ContactError(error: e.toString()));
    }
  }

  Future<void> _addChatUser(
      ContactAddContactUserEvent event, Emitter<ContactState> emit) async {
    try {
      await contactRepository.addChatUser(checkID: event.checkId);
    } catch (e) {
      emit(ContactError(error: e.toString()));
    }
  }

  Future<void> _deleteContactUser(
      ContactDeleteContactUserEvent event, Emitter<ContactState> emit) async {
    try {
      await contactRepository.deleteContactUser(id: event.id);
    } catch (e) {
      emit(ContactError(error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    listContactRepository.close();
    return super.close();
  }
}
