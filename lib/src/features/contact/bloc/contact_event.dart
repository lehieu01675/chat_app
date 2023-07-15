part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class ContactLoadChatUsersEvent extends ContactEvent {
  final List<UserModel> listContactUser;

  const ContactLoadChatUsersEvent({required this.listContactUser});

  @override
  List<Object> get props => [listContactUser];
}

class ContactAddContactUserEvent extends ContactEvent {
  final String checkId;

  const ContactAddContactUserEvent({required this.checkId});

  @override
  List<Object> get props => [checkId];
}

class ContactDeleteContactUserEvent extends ContactEvent {
  final String id;

  const ContactDeleteContactUserEvent({required this.id});

  @override
  List<Object> get props => [id];
}
