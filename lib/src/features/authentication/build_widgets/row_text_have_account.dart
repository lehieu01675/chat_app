import 'package:chatapp/src/helper/text_style_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RowTextHaveAccount extends StatelessWidget {
  final String firstText;
  final String secondText;
  final TapGestureRecognizer recognizer;

  const RowTextHaveAccount({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.recognizer,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textScaleFactor: 1.2,
      text: TextSpan(
        children: [
          TextSpan(
            text: firstText,
            style: TextStyleHelper.dontHavaAccount,
          ),
          TextSpan(
            text: secondText,
            style: TextStyleHelper.signUpInSignInPage,
            recognizer: recognizer,
          ),
        ],
      ),
    );
  }
}
