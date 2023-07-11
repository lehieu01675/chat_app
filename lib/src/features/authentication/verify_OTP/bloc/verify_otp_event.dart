part of 'verify_otp_bloc.dart';

abstract class VerifyOtpEvent extends Equatable {
  const VerifyOtpEvent();

  @override
  List<Object> get props => [];
}

class VerifyOTP extends VerifyOtpEvent {
  final String verificationId;
  final String smsCode;
  final void Function() onError;

  const VerifyOTP({
    required this.verificationId,
    required this.smsCode,
    required this.onError,
  });

  @override
  List<Object> get props => [verificationId, smsCode];
}
