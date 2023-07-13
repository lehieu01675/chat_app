import 'package:chatapp/src/features/authentication/sign_in/widgets/form_sign_in.dart';
import 'package:chatapp/src/l10n/app_localizations.dart';
import 'package:chatapp/src/widgets/background_image.dart';
import 'package:chatapp/src/widgets/navigation_auth_text.dart';
import 'package:chatapp/src/widgets/or_sign_in_with.dart';
import 'package:chatapp/src/widgets/sign_in_with_gg_sms.dart';
import 'package:chatapp/src/widgets/slogan.dart';
import 'package:flutter/gestures.dart';
import 'package:chatapp/src/widgets/build_loading_circle.dart';
import 'package:chatapp/src/widgets/custom_button.dart';
import 'package:chatapp/src/features/authentication/sign_in/bloc/sign_in_bloc.dart';
import 'package:chatapp/src/features/authentication/sign_in/widgets/forgot_password.dart';
import 'package:chatapp/src/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _keyForm = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(),
      child: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            context.go("/dashboard");
          }
          if (state is SignInError) {
            _showStateError(context, state);
          }
        },
        child: BlocBuilder<SignInBloc, SignInState>(
          builder: (context, state) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                    const BackgroundImageWidget(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 120.h),
                          SloganWidget(
                            slogan: AppLocalizations.of(context)!.sloganSignIn,
                            title: AppLocalizations.of(context)!.signIn,
                          ),
                          SizedBox(height: 20.h),
                          _buildBody(context),
                          SizedBox(height: 20.h),
                          NavigationAuthTextWidget(
                              firstText:
                                  AppLocalizations.of(context)!.dontHaveAccount,
                              secondText: AppLocalizations.of(context)!.signUp,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => context.go("/sign_up")),
                        ],
                      ),
                    ),
                    if (state is SignInLoading) ...[const BuildLoadingCircle()]
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FormSignIn(
          emailController: _emailController,
          passwordController: _passwordController,
          keyForm: _keyForm,
        ),
        SizedBox(height: 5.h),
        const ForgotPasswordWidget(),
        SizedBox(height: 5.h),
        CustomButton.curiousBlue(
          label: AppLocalizations.of(context)!.signIn,
          onPress: () => _signIn(context),
        ),
        SizedBox(height: 50.h),
        const OrSignInWithWidget(),
        SizedBox(height: 10.h),
        const SignInWithGoogleSmsWidget(isInSignIn: true),
      ],
    );
  }

  void _signIn(BuildContext context) {
    if (_keyForm.currentState?.validate() ?? false) {
      context.read<SignInBloc>().add(SignInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          ));
    }
  }

  void _showStateError(BuildContext context, SignInError state) {
    DialogUtil.showException(
      context: context,
      onPressedOK: () {},
      title: AppLocalizations.of(context)!.signInFailed,
      message: state.message,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
