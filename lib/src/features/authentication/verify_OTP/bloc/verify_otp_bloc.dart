import 'package:chatapp/src/data/repositories/phone_repo.dart';
import 'package:chatapp/src/data/repositories/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verify_otp_event.dart';

part 'verify_otp_state.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  PhoneRepository phoneRepository;
  UserRepository userRepository;

  VerifyOtpBloc({
    required this.phoneRepository,
    required this.userRepository,
  }) : super(VerifyOtpInitial()) {
    on<VerifyOTP>(_verifyOTP);
  }

  Future<void> _verifyOTP(VerifyOTP event, Emitter<VerifyOtpState> emit) async {
    emit(VerifyOtpLoading());
    try {
      await phoneRepository.verifyOTP(
        smsCode: event.smsCode,
        verificationId: event.verificationId,
        onError: event.onError,
      );
      if (!(await userRepository.checkUserExists())) {
        await userRepository.createUser();
      }
      emit(VerifyOTPSuccess());
    } catch (e) {
      emit(VerifyOtpError(message: e.toString()));
    }
  }
}
