part of 'my_app_bloc.dart';

abstract class MyAppState extends Equatable {
  const MyAppState();

  @override
  List<Object> get props => [];
}

class MyAppInitial extends MyAppState {}

class MyAppUpdateLanguageSuccess extends MyAppState {
  final String languageCode;

  const MyAppUpdateLanguageSuccess({required this.languageCode});

  @override
  List<Object> get props => [languageCode];
}

class MyAppGetDefaultLanguageSuccess extends MyAppState {
  final String languageCode;

  const MyAppGetDefaultLanguageSuccess({required this.languageCode});

  @override
  List<Object> get props => [languageCode];
}

class MyAppError extends MyAppState {
  final String message;

  const MyAppError({required this.message});

  @override
  List<Object> get props => [message];
}
