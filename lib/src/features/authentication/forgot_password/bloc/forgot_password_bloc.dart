import 'package:chatapp/src/data/repositories/forgot_password_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forgot_password_event.dart';

part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordRepository forgotPasswordRepository;

  ForgotPasswordBloc({required this.forgotPasswordRepository})
      : super(ForgotPasswordInitial()) {
    on<ForgotPasswordSendEmail>(_forgotPassword);
  }

  Future<void> _forgotPassword(
      ForgotPasswordSendEmail event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());
    try {
      await forgotPasswordRepository.forgotPassword(email: event.email);
      emit(ForgotPasswordSendSuccess());
    } catch (e) {
      emit(ForgotPasswordError(message: e.toString()));
    }
  }
}
