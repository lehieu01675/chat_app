part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

/// email and password
class SignInWithEmailAndPassword extends SignInEvent {
  final String email;
  final String password;

  const SignInWithEmailAndPassword({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class SignInWithGoogle extends SignInEvent {}

class SignInResetPassword extends SignInEvent {
  final String email;

  const SignInResetPassword({required this.email});

  @override
  List<Object> get props => [email];
}
