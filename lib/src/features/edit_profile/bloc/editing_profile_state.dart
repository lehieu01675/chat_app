part of 'editing_profile_bloc.dart';

abstract class EditingProfileState extends Equatable {
  const EditingProfileState();

  @override
  List<Object> get props => [];
}

class EditingProfileGetCurrentUserSuccess extends EditingProfileState {
  final UserModel currentUser;

  const EditingProfileGetCurrentUserSuccess({required this.currentUser});
  @override
  List<Object> get props => [currentUser];
}

class EditingProfileInit extends EditingProfileState {}

class EditingProfileLoading extends EditingProfileState {}

class EditingProfileUpdatedProfile extends EditingProfileState {}

class EditingProfileError extends EditingProfileState {
  final String error;

  const EditingProfileError({required this.error});
  @override
  List<Object> get props => [error];
}


