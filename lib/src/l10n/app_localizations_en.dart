import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get signIn => 'Sign in';

  @override
  String get signUp => 'Sign up';

  @override
  String get emailValid => 'Invalid email';

  @override
  String get passwordValid => 'Password must be more than 6 characters';

  @override
  String get confirmPasswordValid => 'Confirm password does not match';

  @override
  String get password => 'Password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get sloganForgotPassword => 'We have sent you an email. Click to link to reset your password';

  @override
  String get send => 'Send';

  @override
  String get sendFailed => 'Send failed';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get orSignInWith => 'Or sign in with';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get sloganSignIn => 'FChat: Let\'s keep in touch! ^.^';

  @override
  String get sloganSignUp => 'With Fchat, conversation is always fun';

  @override
  String get sloganPhoneNumber => 'Once submitted, we will verify the phone number quickly and securely. Please wait a moment!';

  @override
  String get wrongPassword => 'Wrong password. Please check your password again';

  @override
  String get emailNotRegistered => 'Email is not registered account';

  @override
  String get signInFailed => 'Sign in failed';

  @override
  String get signUpFailed => 'Sign up failed';

  @override
  String get phoneNumberValid => 'Phone number is valid';

  @override
  String get verifyFailed => 'Verify failed';

  @override
  String get otpIncorrect => 'OTP code is incorrect';

  @override
  String get verifyOTP => 'Verify OTP';

  @override
  String get sloganVerifyOTP => 'We have sent the otp code. Check the sms and enter the code correctly.';

  @override
  String get enterID => 'Enter ID';

  @override
  String get sentEmail => 'Sent email';

  @override
  String get changeLanguage => 'Thay đổi ngôn ngữ';

  @override
  String get delete => 'Delete';

  @override
  String get copiedId => 'Copied ID';

  @override
  String get signOutFailed => 'Sign out failed';

  @override
  String get update => 'Update';

  @override
  String get updateSuccess => 'Update success';

  @override
  String get updateFailed => 'Update failed';
}
