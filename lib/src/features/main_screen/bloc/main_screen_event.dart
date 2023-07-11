part of 'main_screen_bloc.dart';

abstract class MainScreenEvent extends Equatable {
  const MainScreenEvent();

  @override
  List<Object> get props => [];
}
class MainScreenGetListChatUser extends MainScreenEvent {
  final List<UserModel> listChatUser;

  const MainScreenGetListChatUser({required this.listChatUser});
  @override
  List<Object> get props => [listChatUser];
}

class MainScreenAddChatUser extends MainScreenEvent {
  final String checkId;

  const MainScreenAddChatUser({required this.checkId});
  @override
  List<Object> get props => [checkId];
}

class MainScreenDeleteChatUser extends MainScreenEvent {
  final String id;
  const MainScreenDeleteChatUser({required this.id});

  @override
  List<Object> get props => [id];
}
