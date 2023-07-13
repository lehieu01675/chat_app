import 'package:chatapp/src/data/repositories/phone_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'phone_sign_in_event.dart';

part 'phone_sign_in_state.dart';

class PhoneSignInBloc extends Bloc<PhoneSignInEvent, PhoneSignInState> {
  PhoneRepository phoneRepository = GetIt.I.get<PhoneRepository>();

  PhoneSignInBloc() : super(PhoneSignInInit()) {
    on<PhoneSignInSendOTP>(_sendOtp);
  }

  Future<void> _sendOtp(
      PhoneSignInSendOTP event, Emitter<PhoneSignInState> emit) async {
    emit(PhoneSignInLoading());
    try {
      await phoneRepository.sendOtp(
        phoneNumber: event.phoneNumber,
        pushToOtp: event.pushToOtp,
      );
      emit(PhoneSignInSendOTPSuccess());
    } catch (e) {
      emit(PhoneSignInError(message: e.toString()));
      emit(PhoneSignInSendOTPFailed());
    }
  }
}
