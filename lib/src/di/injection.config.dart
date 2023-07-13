// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chatapp/src/data/providers/remote/chat_user_provider.dart'
    as _i3;
import 'package:chatapp/src/data/providers/remote/forgot_password_provider.dart'
    as _i5;
import 'package:chatapp/src/data/providers/remote/google_sign_in_provider.dart'
    as _i6;
import 'package:chatapp/src/data/providers/remote/phone_provider.dart' as _i8;
import 'package:chatapp/src/data/providers/remote/sign_in_provider.dart'
    as _i10;
import 'package:chatapp/src/data/providers/remote/sign_up_provider.dart'
    as _i12;
import 'package:chatapp/src/data/providers/remote/user_provider.dart' as _i14;
import 'package:chatapp/src/data/repositories/chat_user_repository.dart' as _i4;
import 'package:chatapp/src/data/repositories/list_chat_user_repo.dart' as _i7;
import 'package:chatapp/src/data/repositories/phone_repo.dart' as _i9;
import 'package:chatapp/src/data/repositories/sign_in_repo.dart' as _i11;
import 'package:chatapp/src/data/repositories/sign_up_repo.dart' as _i13;
import 'package:chatapp/src/data/repositories/user_repo.dart' as _i15;
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
    gh.factory<_i3.ChatUserProvider>(() => _i3.ChatUserProviderImpl());
    gh.factory<_i4.ChatUserRepository>(() => _i4.ChatUserRepositoryImpl());
    gh.factory<_i5.ForgotPasswordProvider>(
        () => _i5.ForgotPasswordProviderImpl());
    gh.factory<_i6.GoogleSignInProvider>(() => _i6.GoogleSignInProviderImpl());
    gh.factory<_i7.ListChatUserRepository>(
        () => _i7.ListChatUserRepositoryImpl());
    gh.factory<_i8.PhoneProvider>(() => _i8.PhoneProviderImpl());
    gh.factory<_i9.PhoneRepository>(() => _i9.PhoneRepositoryImpl());
    gh.factory<_i10.SignInProvider>(() => _i10.SignInProviderImpl());
    gh.factory<_i11.SignInRepository>(() => _i11.SignInRepositoryImpl());
    gh.factory<_i12.SignUpProvider>(() => _i12.SignUpProviderImpl());
    gh.factory<_i13.SignUpRepository>(() => _i13.SignUpRepositoryImpl());
    gh.factory<_i14.UserProvider>(() => _i14.UserProviderImpl());
    gh.factory<_i15.UserRepository>(() => _i15.UserRepositoryImpl());
    return this;
  }
}
