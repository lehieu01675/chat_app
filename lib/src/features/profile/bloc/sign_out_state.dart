part of 'sign_out_bloc.dart';

abstract class SignOutState extends Equatable {
  const SignOutState();

  @override
  List<Object> get props => [];
}

class SignOutError extends SignOutState {
  final String message;

  const SignOutError({required this.message});
  @override
  List<Object> get props => [message];
}

class SignOutSuccess extends SignOutState {}

class SignOutFailed extends SignOutState {}
