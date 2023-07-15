import 'dart:io';
import 'package:chatapp/src/data/repositories/edit_profile_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileRepository editProfileRepository =
      GetIt.I.get<EditProfileRepository>();

  EditProfileBloc() : super(EditProfileInit()) {
    on<UpdateAvatar>(_updateAvatar);
    on<UpdateProfile>(_updateProfile);
  }

  Future<void> _updateAvatar(
      UpdateAvatar event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoading());
    try {
      await editProfileRepository.updateAvatar(imageFile: event.file);
    } catch (e) {
      emit(EditProfileError(error: e.toString()));
    }
  }

  Future<void> _updateProfile(
      UpdateProfile event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoading());
    try {
      await editProfileRepository.updateProfile(
          introduce: event.introduce,
          email: event.email,
          name: event.name,
          phoneNumber: event.phoneNumber);
      emit(UpdateProfileSuccess());
    } catch (e) {
      emit(EditProfileError(error: e.toString()));
    }
  }
}
