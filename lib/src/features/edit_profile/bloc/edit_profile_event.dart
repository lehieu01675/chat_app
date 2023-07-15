part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfile extends EditProfileEvent {
  final String name;
  final String introduce;
  final String email;
  final String phoneNumber;

  const UpdateProfile({
    required this.name,
    required this.introduce,
    required this.email,
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [name, introduce, email, phoneNumber];
}

class UpdateAvatar extends EditProfileEvent {
  final File file;

  const UpdateAvatar({required this.file});

  @override
  List<Object> get props => [file];
}
