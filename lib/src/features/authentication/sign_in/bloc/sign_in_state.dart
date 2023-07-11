part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInFailed extends SignInState {}

class SignInError extends SignInState {
  final String message;

  const SignInError({required this.message});

  @override
  List<Object> get props => [message];
}
