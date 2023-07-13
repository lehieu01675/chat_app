import 'package:chatapp/src/data/repositories/sign_in_repo.dart';
import 'package:chatapp/src/data/repositories/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInRepository signInRepository = GetIt.I.get<SignInRepository>();
  UserRepository userRepository = GetIt.I.get<UserRepository>();

  SignInBloc() : super(SignInFailed()) {
    on<SignInWithEmailAndPassword>(_signInWithEmailAndPassWord);
    on<SignInWithGoogle>(_signInWithGoogle);
  }

  Future<void> _signInWithEmailAndPassWord(
    SignInWithEmailAndPassword event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInLoading());
    try {
      await signInRepository.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(SignInSuccess());
    } catch (e) {

      emit(SignInError(message: e.toString()));
      emit(SignInFailed());
    }
  }

  Future<void> _signInWithGoogle(
      SignInWithGoogle event, Emitter<SignInState> emit) async {
    emit(SignInLoading());
    try {
      await signInRepository.signInWithGoogle();
      if (!(await userRepository.checkUserExists())) {
        await userRepository.createUser();
      }
      emit(SignInSuccess());
    } catch (e) {
      emit(SignInError(message: e.toString()));
      emit(SignInFailed());
    }
  }
}
