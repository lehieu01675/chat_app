import 'package:flutter/material.dart';

class TransitionHelper {
  static void nextScreen(context, screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  static void pop(context) {
    Navigator.pop(context);
  }


  static void nextScreenReplace(context, screen) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => screen));
  }

  
}
