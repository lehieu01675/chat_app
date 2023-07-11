import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/profile_repo.dart';
part 'sign_out_event.dart';
part 'sign_out_state.dart';

class SignOutBloc extends Bloc<SignOutEvent, SignOutState> {
  SignOutRepository signOutRepository;
  SignOutBloc({required this.signOutRepository}) : super(UnSignedOut()) {
    on<SignOutAccountEvent>(_signOut);
  }
  // sign out
  Future<void> _signOut(
      SignOutAccountEvent event, Emitter<SignOutState> emit) async {
    try {
      await signOutRepository.signOut();
      emit(SignedOut());
    } catch (e) {
      emit(SignOutError(error: e.toString()));
      emit(UnSignedOut());
    }
  }
}
