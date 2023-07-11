part of 'phone_sign_in_bloc.dart';

abstract class PhoneSignInEvent extends Equatable {
  const PhoneSignInEvent();

  @override
  List<Object> get props => [];
}

class PhoneSignInSendOTP extends PhoneSignInEvent {
  final String phoneNumber;
  final void Function(String) pushToOtp;

  const PhoneSignInSendOTP({
    required this.phoneNumber,
    required this.pushToOtp,
  });

  @override
  List<Object> get props => [phoneNumber, pushToOtp];
}


