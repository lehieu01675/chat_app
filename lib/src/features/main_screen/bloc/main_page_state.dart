part of 'main_page_bloc.dart';

abstract class MainScreenState extends Equatable {
  const MainScreenState();

  @override
  List<Object> get props => [];
}

class MainScreenLoading extends MainScreenState {}

class MainScreenGetListChatUserSuccess extends MainScreenState {
  final List<UserModel> listChatUser;

  const MainScreenGetListChatUserSuccess({required this.listChatUser});

  @override
  List<Object> get props => [listChatUser];
}

class MainScreenError extends MainScreenState {
  final String error;

  const MainScreenError({required this.error});

  @override
  List<Object> get props => [error];
}
