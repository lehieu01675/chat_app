import 'package:chatapp/src/data/repositories/sign_out_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'sign_out_event.dart';

part 'sign_out_state.dart';

class SignOutBloc extends Bloc<SignOutEvent, SignOutState> {
  SignOutRepository signOutRepository = GetIt.I.get<SignOutRepository>();

  SignOutBloc() : super(SignOutFailed()) {
    on<SignOutAccount>(_signOut);
  }

  Future<void> _signOut(
      SignOutAccount event, Emitter<SignOutState> emit) async {
    try {
      await signOutRepository.signOut();
      emit(SignOutSuccess());
    } catch (e) {
      emit(SignOutError(message: e.toString()));
      emit(SignOutFailed());
    }
  }
}
