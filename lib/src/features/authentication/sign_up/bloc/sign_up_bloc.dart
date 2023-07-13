import 'package:chatapp/src/data/repositories/sign_up_repo.dart';
import 'package:chatapp/src/data/repositories/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpRepository signUpRepository = GetIt.I.get<SignUpRepository>();
  UserRepository userRepository = GetIt.I.get<UserRepository>();

  SignUpBloc() : super(SignUpFailed()) {
    on<SignUpWithEmailAndPassword>(_signUpWithEmailAndPassWord);
    on<SignUpWithGoogle>(_signInWithGoogle);
  }

  Future<void> _signUpWithEmailAndPassWord(
      SignUpWithEmailAndPassword event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());
    try {
      await signUpRepository.signUpWithEmailAndPassword(
          email: event.email, password: event.password);
      if (!(await userRepository.checkUserExists())) {
        await userRepository.createUser();
      }
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpError(message: e.toString()));
      emit(SignUpFailed());
    }
  }

  Future<void> _signInWithGoogle(
      SignUpWithGoogle event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());
    try {
      await signUpRepository.signInWithGoogle();
      if (!(await userRepository.checkUserExists())) {
        await userRepository.createUser();
      }
      emit(SignUpGoogleSuccess());
    } catch (e) {
      emit(SignUpError(message: e.toString()));
      emit(SignUpFailed());
    }
  }
}
