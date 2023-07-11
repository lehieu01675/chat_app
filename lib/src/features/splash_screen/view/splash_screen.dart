import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chatapp/src/lay_out/auth_gate.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  final String _name = 'FChat';
  final TextStyle _logoTextStyle = const TextStyle(
      fontSize: 60,
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontFamily: 'ShantellSans-Regular');

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 300,
      splash: Text(_name, style: _logoTextStyle),
      animationDuration: const Duration(milliseconds: 300),
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: const Color(0xff0E77CB),
      nextScreen: const AuthGate(),
    );
  }
}
