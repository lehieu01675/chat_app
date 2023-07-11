import 'package:chatapp/src/features/authentication/sign_in/bloc/sign_in_bloc.dart';
import 'package:chatapp/src/features/authentication/sign_up/bloc/sign_up_bloc.dart';
import 'package:chatapp/src/theme/assets.gen.dart';
import 'package:chatapp/src/widgets/custom_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignInWithGoogleSmsWidget extends StatelessWidget {
  final bool isInSignIn;

  const SignInWithGoogleSmsWidget({
    super.key,
    required this.isInSignIn,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomSVGImage(
          svgPath: Assets.svg.google.path,
          width: 60.w,
          height: 60.w,
          onTap: () {
            isInSignIn
                ? _authenticateWithGoogleSignIn(context)
                : _authenticateWithGoogleSignUp(context);
          },
        ),
        SizedBox(width: 30.w),
        CustomSVGImage(
          svgPath: Assets.svg.sms.path,
          width: 50.w,
          height: 50.w,
          onTap: () {
            isInSignIn
                ? context.go("/sign_in/phone_number")
                : context.go("/sign_up/phone_number");
          },
        ),
      ],
    );
  }

  void _authenticateWithGoogleSignIn(BuildContext context) {
    context.read<SignInBloc>().add(SignInWithGoogle());
  }

  void _authenticateWithGoogleSignUp(BuildContext context) {
    context.read<SignUpBloc>().add(SignUpWithGoogle());
  }
}
