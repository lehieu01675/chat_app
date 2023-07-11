import 'package:chatapp/src/theme/font_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class NavigationAuthTextWidget extends StatelessWidget {
  final String firstText;
  final String secondText;
  final TapGestureRecognizer recognizer;

  const NavigationAuthTextWidget({
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
            style: FontTheme.silverChalice15W400Roboto,
          ),
          TextSpan(
            text: secondText,
            style: FontTheme.curiousBlue20W500UnderlinePoppins,
            recognizer: recognizer,
          ),
        ],
      ),
    );
  }
}
