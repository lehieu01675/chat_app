part of 'editing_profile_bloc.dart';

abstract class EditingProfileEvent extends Equatable {
  const EditingProfileEvent();

  @override
  List<Object> get props => [];
}

class EditingProfileGetCurrentUser extends EditingProfileEvent {}

class EditingProfileUpdateProfile extends EditingProfileEvent {
  final String name;
  final String introduce;
  final String email;
  final String phoneNumber;

  const EditingProfileUpdateProfile(
      {required this.name,
      required this.introduce,
      required this.email,
      required this.phoneNumber});
  @override
  List<Object> get props => [name, introduce, email, phoneNumber];
}

class EditingProfileUpdateAvatar extends EditingProfileEvent {
  final File file;

  const EditingProfileUpdateAvatar(this.file);
  @override
  List<Object> get props => [file];
}
