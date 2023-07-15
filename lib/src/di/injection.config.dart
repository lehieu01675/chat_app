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
    as _i11;
import 'package:chatapp/src/data/providers/remote/chat_user_provider.dart'
    as _i5;
import 'package:chatapp/src/data/providers/remote/contact_provider.dart' as _i7;
import 'package:chatapp/src/data/providers/remote/edit_profile_provider.dart'
    as _i9;
import 'package:chatapp/src/data/providers/remote/forgot_password_provider.dart'
    as _i13;
import 'package:chatapp/src/data/providers/remote/google_sign_in_provider.dart'
    as _i15;
import 'package:chatapp/src/data/providers/remote/message_provider.dart'
    as _i19;
import 'package:chatapp/src/data/providers/remote/phone_provider.dart' as _i21;
import 'package:chatapp/src/data/providers/remote/sign_in_provider.dart'
    as _i23;
import 'package:chatapp/src/data/providers/remote/sign_out_provider.dart'
    as _i25;
import 'package:chatapp/src/data/providers/remote/sign_up_provider.dart'
    as _i27;
import 'package:chatapp/src/data/providers/remote/user_provider.dart' as _i29;
import 'package:chatapp/src/data/repositories/app_language_repo.dart' as _i4;
import 'package:chatapp/src/data/repositories/chat_user_repository.dart' as _i6;
import 'package:chatapp/src/data/repositories/contact_repo.dart' as _i8;
import 'package:chatapp/src/data/repositories/edit_profile_repo.dart' as _i10;
import 'package:chatapp/src/data/repositories/file_picker_repo.dart' as _i12;
import 'package:chatapp/src/data/repositories/forgot_password_repo.dart'
    as _i14;
import 'package:chatapp/src/data/repositories/list_chat_user_repo.dart' as _i16;
import 'package:chatapp/src/data/repositories/list_contact_repo.dart' as _i17;
import 'package:chatapp/src/data/repositories/list_message_repo.dart' as _i18;
import 'package:chatapp/src/data/repositories/message_repo.dart' as _i20;
import 'package:chatapp/src/data/repositories/phone_repo.dart' as _i22;
import 'package:chatapp/src/data/repositories/sign_in_repo.dart' as _i24;
import 'package:chatapp/src/data/repositories/sign_out_repository.dart' as _i26;
import 'package:chatapp/src/data/repositories/sign_up_repo.dart' as _i28;
import 'package:chatapp/src/data/repositories/user_repo.dart' as _i30;
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
    gh.factory<_i7.ContactProvider>(() => _i7.ContactProviderImpl());
    gh.factory<_i8.ContactRepository>(() => _i8.ContactRepositoryImpl());
    gh.factory<_i9.EditProfileProvider>(() => _i9.EditProfileProviderImpl());
    gh.factory<_i10.EditProfileRepository>(
        () => _i10.EditProfileRepositoryImpl());
    gh.factory<_i11.FilePickerProvider>(() => _i11.FilePickerProviderImpl());
    gh.factory<_i12.FilePickerRepository>(
        () => _i12.FilePickerRepositoryImpl());
    gh.factory<_i13.ForgotPasswordProvider>(
        () => _i13.ForgotPasswordProviderImpl());
    gh.factory<_i14.ForgotPasswordRepository>(
        () => _i14.ForgotPasswordRepositoryImpl());
    gh.factory<_i15.GoogleSignInProvider>(
        () => _i15.GoogleSignInProviderImpl());
    gh.factory<_i16.ListChatUserRepository>(
        () => _i16.ListChatUserRepositoryImpl());
    gh.factory<_i17.ListContactRepository>(
        () => _i17.ListContactRepositoryImpl());
    gh.factory<_i18.ListMessageRepository>(
        () => _i18.ListMessageRepositoryImpl());
    gh.factory<_i19.MessageProvider>(() => _i19.MessageProviderImpl());
    gh.factory<_i20.MessageRepository>(() => _i20.MessageRepositoryImpl());
    gh.factory<_i21.PhoneProvider>(() => _i21.PhoneProviderImpl());
    gh.factory<_i22.PhoneRepository>(() => _i22.PhoneRepositoryImpl());
    gh.factory<_i23.SignInProvider>(() => _i23.SignInProviderImpl());
    gh.factory<_i24.SignInRepository>(() => _i24.SignInRepositoryImpl());
    gh.factory<_i25.SignOutProvider>(() => _i25.SignOutProviderImpl());
    gh.factory<_i26.SignOutRepository>(() => _i26.SignOutRepositoryImpl());
    gh.factory<_i27.SignUpProvider>(() => _i27.SignUpProviderImpl());
    gh.factory<_i28.SignUpRepository>(() => _i28.SignUpRepositoryImpl());
    gh.factory<_i29.UserProvider>(() => _i29.UserProviderImpl());
    gh.factory<_i30.UserRepository>(() => _i30.UserRepositoryImpl());
    return this;
  }
}
