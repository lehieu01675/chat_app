part of 'phone_sign_in_bloc.dart';

abstract class PhoneSignInState extends Equatable {
  const PhoneSignInState();

  @override
  List<Object> get props => [];
}

class PhoneSignInInit extends PhoneSignInState {}

class PhoneSignInSendOTPFailed extends PhoneSignInState {}

class PhoneSignInSendOTPSuccess extends PhoneSignInState {}

class PhoneSignInLoading extends PhoneSignInState {}

class PhoneSignInError extends PhoneSignInState {
  final String message;

  const PhoneSignInError({required this.message});

  @override
  List<Object> get props => [message];
}
