import 'app_localizations.dart';

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get signIn => 'Đăng nhập';

  @override
  String get signUp => 'Đăng kí';

  @override
  String get emailValid => 'Email không hợp lệ';

  @override
  String get passwordValid => 'Mật khẩu phải trên 6 ký tự';

  @override
  String get confirmPasswordValid => 'Xác nhận mật khẩu không khớp';

  @override
  String get password => 'Mật khẩu';

  @override
  String get forgotPassword => 'Quên mật khẩu?';

  @override
  String get sloganForgotPassword => 'Chúng tôi đã gửi mail tới gmail của bạn. Nhấn vào link trong mail để đổi mật khẩu';

  @override
  String get send => 'Gửi';

  @override
  String get sendFailed => 'Gửi thất bại';

  @override
  String get phoneNumber => 'Số điện thoại';

  @override
  String get orSignInWith => 'Hoặc đăng nhập với';

  @override
  String get dontHaveAccount => 'Chưa có tài khoản? ';

  @override
  String get alreadyHaveAccount => 'Đã có tài khoản? ';

  @override
  String get sloganSignIn => 'FChat: Giữ liên lạc với nhau nhé! ^.^';

  @override
  String get sloganSignUp => 'với FChat, cuộc trò chuyện luôn trở nên vui vẻ';

  @override
  String get sloganPhoneNumber => 'Sau khi gửi, chúng tôi sẽ xác minh số điện thoại một cách nhanh chóng và an toàn. Xin vui lòng chờ trong giây lát!';

  @override
  String get wrongPassword => 'Sai mật khẩu. Vui lòng kiểm tra lại mật khẩu.';

  @override
  String get emailNotRegistered => 'Email này chưa được đăng kí tài khoản';

  @override
  String get signInFailed => 'Đăng nhập thất bại';

  @override
  String get signUpFailed => 'Đăng kí thất bại';

  @override
  String get phoneNumberValid => 'Số điện thoại không hợp lệ';

  @override
  String get verifyFailed => 'Xác minh thất bại';

  @override
  String get otpIncorrect => 'Mã OTP không chính xác';

  @override
  String get verifyOTP => 'Xác minh mã OTP';

  @override
  String get sloganVerifyOTP => 'Chúng tôi đã gửi mã otp. Kiểm tra sms và điền chính xác mã.';

  @override
  String get enterID => 'Nhập ID';

  @override
  String get sentEmail => 'Đã gửi email';
}
