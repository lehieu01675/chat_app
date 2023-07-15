part of 'edit_profile_bloc.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

class EditProfileInit extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class UpdateProfileSuccess extends EditProfileState {}

class EditProfileError extends EditProfileState {
  final String error;

  const EditProfileError({required this.error});
  @override
  List<Object> get props => [error];
}
