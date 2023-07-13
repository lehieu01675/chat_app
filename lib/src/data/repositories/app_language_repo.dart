import 'package:chatapp/src/data/providers/local/app_language_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

abstract class AppLanguageRepository {
  Future<String> getDefaultLanguage();

  Future<String> updateLanguage();
}

@Injectable(as: AppLanguageRepository)
class AppLanguageRepositoryImpl extends AppLanguageRepository {
  final AppLanguageProvider _appLanguageProvider =
      GetIt.I.get<AppLanguageProvider>();

  @override
  Future<String> getDefaultLanguage() async {
    return await _appLanguageProvider.getDefaultLanguage();
  }

  @override
  Future<String> updateLanguage() async {
    return await _appLanguageProvider.updateLanguage();
  }
}
