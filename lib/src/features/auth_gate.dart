import 'package:chatapp/src/features/authentication/sign_in/page/sign_in_page.dart';
import 'package:chatapp/src/features/dash_board/page/dash_board_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const DashboardPage();
        }
        return const SignInPage();
      },
    );
  }
}
