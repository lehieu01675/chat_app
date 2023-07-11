part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordSendEmail extends ForgotPasswordEvent {
  final String email;

  const ForgotPasswordSendEmail({required this.email});

  @override
  List<Object> get props => [email];
}
