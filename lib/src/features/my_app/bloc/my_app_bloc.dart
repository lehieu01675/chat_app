import 'package:chatapp/src/data/repositories/app_language_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'my_app_event.dart';

part 'my_app_state.dart';

class MyAppBloc extends Bloc<MyAppEvent, MyAppState> {
  AppLanguageRepository appLanguageRepository =
      GetIt.I.get<AppLanguageRepository>();

  MyAppBloc() : super(MyAppInitial()) {
    on<MyAppGetDefaultLanguage>(_getDefaultLanguage);
    on<MyAppUpdateLanguage>(_updateLanguage);
  }

  Future<void> _updateLanguage(
      MyAppUpdateLanguage event, Emitter<MyAppState> emit) async {
    try {
      String languageCode = await appLanguageRepository.updateLanguage();
      emit(MyAppUpdateLanguageSuccess(languageCode: languageCode));
    } catch (e) {
      emit(MyAppError(message: e.toString()));
    }
  }

  Future<void> _getDefaultLanguage(
    MyAppGetDefaultLanguage event,
    Emitter<MyAppState> emit,
  ) async {
    try {
      String languageCode = await appLanguageRepository.getDefaultLanguage();
      emit(MyAppGetDefaultLanguageSuccess(languageCode: languageCode));
    } catch (e) {
      emit(MyAppError(message: e.toString()));
    }
  }
}
