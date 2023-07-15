import 'package:chatapp/src/constant/text_cons.dart';
import 'package:chatapp/src/features/authentication/forgot_password/page/forgot_password_page.dart';
import 'package:chatapp/src/features/authentication/phong_number/page/phone_number_page.dart';
import 'package:chatapp/src/features/authentication/sign_in/page/sign_in_page.dart';
import 'package:chatapp/src/features/authentication/sign_up/page/sign_up_page.dart';
import 'package:chatapp/src/features/authentication/verify_OTP/page/verify_otp_screen.dart';
import 'package:chatapp/src/features/chat/page/chat_screen.dart';
import 'package:chatapp/src/features/contact/page/contact_page.dart';
import 'package:chatapp/src/features/dash_board/page/dash_board_page.dart';
import 'package:chatapp/src/features/edit_profile/page/edit_profile_page.dart';
import 'package:chatapp/src/features/main_screen/page/main_page.dart';
import 'package:chatapp/src/features/profile/page/profile_page.dart';
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
            path: TextConstant.signInPath,
            builder: (context, state) => const SignInPage(),
            routes: [
              GoRoute(
                path: TextConstant.forgotPasswordPath,
                builder: (context, state) => ForgotPasswordPage(),
              ),
              GoRoute(
                  path: TextConstant.phoneNumberPath,
                  builder: (context, state) => const PhoneSignInPage(),
                  routes: [
                    GoRoute(
                        path: TextConstant.verifyOtpPath,
                        builder: (context, state) {
                          final verificationId = state.queryParameters[
                                  TextConstant.verificationID] ??
                              '';
                          final phoneNumber =
                              state.queryParameters[TextConstant.phoneNumber] ??
                                  '';
                          return VerifyOTPPage(
                            verificationId: verificationId,
                            phoneNumber: phoneNumber,
                          );
                        })
                  ]),
            ],
          ),
          GoRoute(
            path: TextConstant.signUpPath,
            builder: (context, state) => const SignUpPage(),
          ),
          GoRoute(
            path: TextConstant.dashboardPath,
            builder: (context, state) => const DashboardPage(),
            routes: [
              GoRoute(
                  path: TextConstant.mainPagePath,
                  builder: (context, state) => const MainPage(),
                  routes: [
                    GoRoute(
                      path: TextConstant.chatPath,
                      builder: (context, state) => const ChatPage(),
                    ),
                  ]),
              GoRoute(
                path: TextConstant.contactPagePath,
                builder: (context, state) => const ContactPage(),
              ),
              GoRoute(
                  path: TextConstant.profilePagePath,
                  builder: (context, state) => const ProfilePage(),
                  routes: [
                    GoRoute(
                      path: TextConstant.editProfilePage,
                      builder: (context, state) => const EditProfilePage(),
                    ),
                  ])
            ],
          ),
        ],
      ),
    ],
  );
}
