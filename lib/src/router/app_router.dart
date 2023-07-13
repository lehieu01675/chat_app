import 'package:chatapp/src/features/authentication/forgot_password/page/forgot_password_page.dart';
import 'package:chatapp/src/features/authentication/phong_number/page/phone_number_page.dart';
import 'package:chatapp/src/features/authentication/sign_in/page/sign_in_page.dart';
import 'package:chatapp/src/features/authentication/sign_up/page/sign_up_page.dart';
import 'package:chatapp/src/features/authentication/verify_OTP/page/verify_otp_screen.dart';
import 'package:chatapp/src/features/dash_board/page/dash_board_page.dart';
import 'package:chatapp/src/lay_out/auth_gate.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) => const AuthGate(),
          routes: [
            GoRoute(
              path: 'sign_in',
              builder: (context, state) => const SignInPage(),
              routes: [
                GoRoute(
                  path: 'forgot_password',
                  builder: (context, state) => ForgotPasswordPage(),
                ),
                GoRoute(
                    path: 'phone_number',
                    builder: (context, state) => const PhoneSignInPage(),
                    routes: [
                      GoRoute(
                          path: 'verify_OTP',
                          builder: (context, state) {
                            final verificationId =
                                state.queryParameters['verificationId'] ?? '';
                            final phoneNumber =
                                state.queryParameters['phoneNumber'] ?? '';
                            return VerifyOTPPage(
                              verificationId: verificationId,
                              phoneNumber: phoneNumber,
                            );
                          })
                    ]),
              ],
            ),
            GoRoute(
                path: 'sign_up',
                builder: (context, state) => const SignUpPage(),
                routes: [
                  GoRoute(
                    path: 'phone_number',
                    builder: (context, state) => const PhoneSignInPage(),
                  )
                ]),
            GoRoute(
              path: 'dashboard',
              builder: (context, state) => const DashboardPage(),
            ),
          ]),
    ],
  );
}
