import 'package:flutter/material.dart';
import 'package:chatapp/src/helper/color_helper.dart';

class TextStyleHelper {
  static TextStyle hintTextOfTextFormField = const TextStyle(
    fontSize: 18,
    color: Color(0xff666161),
    fontWeight: FontWeight.w500,
  );

  static TextStyle title = const TextStyle(
    fontSize: 20,
    color: Color(0xffFFFFFF),
    fontWeight: FontWeight.w600,
  );

  static TextStyle nameOfProfile = const TextStyle(
    fontSize: 30,
    color: Color(0xff000000),
    fontWeight: FontWeight.w600,
  );

  static TextStyle nameOfUserMessagePage = const TextStyle(
    fontSize: 20,
    color: Color(0xff0F1828),
    fontWeight: FontWeight.w400,
  );

  static TextStyle textOfTextFormField = const TextStyle(
    fontSize: 18,
    color: Color(0xff000000),
    fontWeight: FontWeight.w500,
  );

  static TextStyle message = const TextStyle(
    fontSize: 14,
    color: Color(0xff000000),
    fontWeight: FontWeight.w500,
  );
  static TextStyle bigSlogan = const TextStyle(
    fontSize: 35,
    color: Color(0xff464444),
    fontWeight: FontWeight.w700,
  );

  static TextStyle smallSlogan = const TextStyle(
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );

  static TextStyle forgotPassword = TextStyle(
    decoration: TextDecoration.underline,
    fontSize: 15,
    color: const Color(0xff2D2626).withOpacity(0.7),
    fontWeight: FontWeight.w500,
  );

  static TextStyle dontHavaAccount = TextStyle(
    fontSize: 15,
    color: const Color(0xff2D2626).withOpacity(0.7),
    fontWeight: FontWeight.w500,
  );
  static TextStyle signUpInSignInPage = TextStyle(
    decoration: TextDecoration.underline,
    fontSize: 20,
    color: ColorHelper.backgroundButtonSignIn,
    fontWeight: FontWeight.w600,
  );

  static TextStyle titleAppbar = const TextStyle(
    fontSize: 35,
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );

  static TextStyle optionProfilePage = const TextStyle(
    fontSize: 18,
    color: Color(0xff0F1828),
    fontWeight: FontWeight.w400,
  );

  static TextStyle guestMessage = const TextStyle(
    fontSize: 18,
    color: Color(0xff0F1828),
    fontWeight: FontWeight.w400,
  );
  static TextStyle guestMessageSmall = const TextStyle(
    fontSize: 14,
    color: Color(0xff0F1828),
    fontWeight: FontWeight.w400,
  );
  static TextStyle currentMessage = const TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );
  static TextStyle currentMessageSmall = const TextStyle(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );
}
