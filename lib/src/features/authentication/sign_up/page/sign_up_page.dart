import 'package:chatapp/src/features/authentication/sign_up/widgets/form_sign_up.dart';
import 'package:chatapp/src/l10n/app_localizations.dart';
import 'package:chatapp/src/router/app_pages.dart';
import 'package:chatapp/src/widgets/background_image.dart';
import 'package:chatapp/src/widgets/custom_button.dart';
import 'package:chatapp/src/widgets/navigation_auth_text.dart';
import 'package:chatapp/src/widgets/or_sign_in_with.dart';
import 'package:chatapp/src/widgets/sign_in_with_gg_sms.dart';
import 'package:chatapp/src/widgets/slogan.dart';
import 'package:chatapp/src/features/authentication/sign_up/bloc/sign_up_bloc.dart';
import 'package:chatapp/src/utils/dialog_util.dart';
import 'package:chatapp/src/widgets/build_loading_circle.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            context.go(RoutePaths.signIn);
          }
          if (state is SignUpGoogleSuccess) {
            context.go(RoutePaths.dashboard);
          }
          if (state is SignUpError) {
            _showStateError(context, state);
          }
        },
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
                          slogan: AppLocalizations.of(context)!.sloganSignUp,
                          title: AppLocalizations.of(context)!.signUp,
                        ),
                        SizedBox(height: 20.h),
                        _buildBody(context),
                        SizedBox(height: 10.h),
                        NavigationAuthTextWidget(
                            firstText: AppLocalizations.of(context)!
                                .alreadyHaveAccount,
                            secondText: AppLocalizations.of(context)!.signIn,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => context.go(RoutePaths.signIn)),
                      ],
                    ),
                  ),
                  if (state is SignUpLoading) ...[const BuildLoadingCircle()]
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        FormSignUp(
          emailController: _emailController,
          passwordController: _passwordController,
          confirmPasswordController: _confirmPasswordController,
          keyForm: SignUpPage._keyForm,
        ),
        SizedBox(height: 10.h),
        CustomButton.curiousBlue(
          onPress: () => _signUp(context),
          label: AppLocalizations.of(context)!.signUp,
        ),
        SizedBox(height: 50.h),
        const OrSignInWithWidget(),
        SizedBox(height: 10.h),
        const SignInWithGoogleSmsWidget(isInSignIn: false),
      ],
    );
  }

  void _signUp(BuildContext context) {
    if (SignUpPage._keyForm.currentState?.validate() ?? false) {
      context.read<SignUpBloc>().add(SignUpWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim()));
    }
  }

  void _showStateError(BuildContext context, SignUpError state) {
    DialogUtil.showException(
      context: context,
      onPressedOK: () {},
      title: AppLocalizations.of(context)!.signUpFailed,
      message: state.message,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }
}
