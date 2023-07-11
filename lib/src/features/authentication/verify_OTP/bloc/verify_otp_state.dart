part of 'verify_otp_bloc.dart';

abstract class VerifyOtpState extends Equatable {
  const VerifyOtpState();

  @override
  List<Object> get props => [];
}

class VerifyOtpInitial extends VerifyOtpState {}

class VerifyOtpLoading extends VerifyOtpState {}

class VerifyOTPSuccess extends VerifyOtpState {}

class VerifyOtpError extends VerifyOtpState {
  final String message;

  const VerifyOtpError({required this.message});

  @override
  List<Object> get props => [];
}
