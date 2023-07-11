import 'dart:async';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/contact_repo.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactRepository contactRepository;
  StreamSubscription<List<UserModel>>? _subscription;
  ContactBloc({required this.contactRepository}) : super(ContactLoading()) {
    on<ContactLoadChatUsersEvent>(_loadContactUser);
    on<ContactDeleteContactUserEvent>(_deleteContactUser);
    on<ContactAddContactUserEvent>(_addChatUser);

    _subscription = contactRepository.streamContactUser.listen((event) {
      add(ContactLoadChatUsersEvent(listContactUser: event));
    });
  }

  FutureOr<void> _loadContactUser(
      ContactLoadChatUsersEvent event, Emitter<ContactState> emit) async {
    try {
      emit(
          ContactLoadChatUserSuccess(listContactUser: event.listContactUser));
    } catch (e) {
      emit(ContactError(error: e.toString()));
    }
  }

  Future<void> _addChatUser(
      ContactAddContactUserEvent event, Emitter<ContactState> emit) async {
    try {
      await contactRepository.addChatUser(event.checkId);

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
    contactRepository.close();
    return super.close();
  }
}
