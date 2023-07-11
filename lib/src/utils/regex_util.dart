import 'package:flutter/cupertino.dart';

class RegexUtil {
  static bool emailValid({
    required BuildContext context,
    required String email,
  }) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool passwordValid({
    required BuildContext context,
    required String password,
  }) {
    if (password.length < 6) {
      return false;
    } else {
      return true;
    }
  }

  static bool confirmPasswordValid({
    required BuildContext context,
    required String confirmPassword,
    required String password,
  }) {
    if (confirmPassword.trim() == password.trim()) {
      return true;
    } else {
      return false;
    }
  }

  static bool phoneNumberValid({required String phoneNumber}) {
    RegExp regex = RegExp(r'^\d+$');
    return (regex.hasMatch(phoneNumber) &&
        phoneNumber.length > 8 &&
        phoneNumber.length < 11);
  }
}
