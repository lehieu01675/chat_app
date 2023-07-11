part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpGoogleSuccess extends SignUpState {}

class SignUpFailed extends SignUpState {}

class SignUpError extends SignUpState {
  final String message;

  const SignUpError({required this.message});

  @override
  List<Object> get props => [message];
}
