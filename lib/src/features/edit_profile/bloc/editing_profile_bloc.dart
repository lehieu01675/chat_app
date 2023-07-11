import 'dart:io';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/features/edit_profile/repositories/edit_profile_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'editing_profile_event.dart';
part 'editing_profile_state.dart';


class EditingProfileBloc
    extends Bloc<EditingProfileEvent, EditingProfileState> {
  EditingProfileRepository editingProfileRepository;

  EditingProfileBloc({required this.editingProfileRepository})
      : super(EditingProfileInit()) {
    on<EditingProfileGetCurrentUser>(_getCurrentUser);
    on<EditingProfileUpdateAvatar>(_updateAvatar);
    on<EditingProfileUpdateProfile>(_updateProfile);
  }

  /// get information of current user for editing profile screen
  Future<void> _getCurrentUser(EditingProfileGetCurrentUser event,
      Emitter<EditingProfileState> emit) async {
    emit(EditingProfileLoading());
    try {
      UserModel user = await editingProfileRepository.getCurrentUser();
      emit(EditingProfileGetCurrentUserSuccess(currentUser: user));
    } catch (e) {
      emit(EditingProfileError(error: e.toString()));
    }
  }

  Future<void> _updateAvatar(EditingProfileUpdateAvatar event,
      Emitter<EditingProfileState> emit) async {
    emit(EditingProfileLoading());
    try {
      await editingProfileRepository.updateAvatar(event.file);
    } catch (e) {
      emit(EditingProfileError(error: e.toString()));
    }
  }

  Future<void> _updateProfile(EditingProfileUpdateProfile event,
      Emitter<EditingProfileState> emit) async {
    emit(EditingProfileLoading());
    try {
      await editingProfileRepository.updateProfile(
          introduce: event.introduce,
          email: event.email,
          name: event.name,
          phoneNumber: event.phoneNumber);
      emit(EditingProfileUpdatedProfile());
    } catch (e) {
      emit(EditingProfileError(error: e.toString()));
    }
  }
}
