part of 'contact_bloc.dart';

abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactLoadChatUserSuccess extends ContactState {
  final List<UserModel> listContactUser;
  const ContactLoadChatUserSuccess({required this.listContactUser});

  @override
  List<Object> get props => [listContactUser];
}

class ContactError extends ContactState {
  final String error;

  const ContactError({required this.error});
  @override
  List<Object> get props => [error];
}
