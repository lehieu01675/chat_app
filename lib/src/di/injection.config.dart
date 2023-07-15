// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chatapp/src/data/providers/local/app_language_provider.dart'
    as _i3;
import 'package:chatapp/src/data/providers/local/file_picker_provider.dart'
    as _i9;
import 'package:chatapp/src/data/providers/remote/chat_user_provider.dart'
    as _i5;
import 'package:chatapp/src/data/providers/remote/edit_profile_provider.dart'
    as _i7;
import 'package:chatapp/src/data/providers/remote/forgot_password_provider.dart'
    as _i11;
import 'package:chatapp/src/data/providers/remote/google_sign_in_provider.dart'
    as _i13;
import 'package:chatapp/src/data/providers/remote/message_provider.dart'
    as _i16;
import 'package:chatapp/src/data/providers/remote/phone_provider.dart' as _i18;
import 'package:chatapp/src/data/providers/remote/sign_in_provider.dart'
    as _i20;
import 'package:chatapp/src/data/providers/remote/sign_out_provider.dart'
    as _i22;
import 'package:chatapp/src/data/providers/remote/sign_up_provider.dart'
    as _i24;
import 'package:chatapp/src/data/providers/remote/user_provider.dart' as _i26;
import 'package:chatapp/src/data/repositories/app_language_repo.dart' as _i4;
import 'package:chatapp/src/data/repositories/chat_user_repository.dart' as _i6;
import 'package:chatapp/src/data/repositories/edit_profile_repo.dart' as _i8;
import 'package:chatapp/src/data/repositories/file_picker_repo.dart' as _i10;
import 'package:chatapp/src/data/repositories/forgot_password_repo.dart'
    as _i12;
import 'package:chatapp/src/data/repositories/list_chat_user_repo.dart' as _i14;
import 'package:chatapp/src/data/repositories/list_message_repo.dart' as _i15;
import 'package:chatapp/src/data/repositories/message_repo.dart' as _i17;
import 'package:chatapp/src/data/repositories/phone_repo.dart' as _i19;
import 'package:chatapp/src/data/repositories/sign_in_repo.dart' as _i21;
import 'package:chatapp/src/data/repositories/sign_out_repository.dart' as _i23;
import 'package:chatapp/src/data/repositories/sign_up_repo.dart' as _i25;
import 'package:chatapp/src/data/repositories/user_repo.dart' as _i27;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.AppLanguageProvider>(() => _i3.AppLanguageProviderImpl());
    gh.factory<_i4.AppLanguageRepository>(
        () => _i4.AppLanguageRepositoryImpl());
    gh.factory<_i5.ChatUserProvider>(() => _i5.ChatUserProviderImpl());
    gh.factory<_i6.ChatUserRepository>(() => _i6.ChatUserRepositoryImpl());
    gh.factory<_i7.EditProfileProvider>(() => _i7.EditProfileProviderImpl());
    gh.factory<_i8.EditProfileRepository>(
        () => _i8.EditProfileRepositoryImpl());
    gh.factory<_i9.FilePickerProvider>(() => _i9.FilePickerProviderImpl());
    gh.factory<_i10.FilePickerRepository>(
        () => _i10.FilePickerRepositoryImpl());
    gh.factory<_i11.ForgotPasswordProvider>(
        () => _i11.ForgotPasswordProviderImpl());
    gh.factory<_i12.ForgotPasswordRepository>(
        () => _i12.ForgotPasswordRepositoryImpl());
    gh.factory<_i13.GoogleSignInProvider>(
        () => _i13.GoogleSignInProviderImpl());
    gh.factory<_i14.ListChatUserRepository>(
        () => _i14.ListChatUserRepositoryImpl());
    gh.factory<_i15.ListMessageRepository>(
        () => _i15.ListMessageRepositoryImpl());
    gh.factory<_i16.MessageProvider>(() => _i16.MessageProviderImpl());
    gh.factory<_i17.MessageRepository>(() => _i17.MessageRepositoryImpl());
    gh.factory<_i18.PhoneProvider>(() => _i18.PhoneProviderImpl());
    gh.factory<_i19.PhoneRepository>(() => _i19.PhoneRepositoryImpl());
    gh.factory<_i20.SignInProvider>(() => _i20.SignInProviderImpl());
    gh.factory<_i21.SignInRepository>(() => _i21.SignInRepositoryImpl());
    gh.factory<_i22.SignOutProvider>(() => _i22.SignOutProviderImpl());
    gh.factory<_i23.SignOutRepository>(() => _i23.SignOutRepositoryImpl());
    gh.factory<_i24.SignUpProvider>(() => _i24.SignUpProviderImpl());
    gh.factory<_i25.SignUpRepository>(() => _i25.SignUpRepositoryImpl());
    gh.factory<_i26.UserProvider>(() => _i26.UserProviderImpl());
    gh.factory<_i27.UserRepository>(() => _i27.UserRepositoryImpl());
    return this;
  }
}
