import 'package:chatapp/src/data/repositories/sign_up_repo.dart';
import 'package:chatapp/src/data/repositories/user_repo.dart';
import 'package:chatapp/src/features/authentication/build_widgets/row_or_sign_in_with.dart';
import 'package:chatapp/src/features/authentication/sign_up/build_widgets/form_sign_up.dart';
import 'package:chatapp/src/l10n/app_localizations.dart';
import 'package:chatapp/src/widgets/background_image.dart';
import 'package:chatapp/src/widgets/custom_button.dart';
import 'package:chatapp/src/widgets/navigation_auth_text.dart';
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

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  static final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(
        signUpRepository: SignUpRepository(),
        userRepository: UserRepository(),
      ),
      child: BlocConsumer<SignUpBloc, SignUpState>(listener: (context, state) {
        if (state is SignUpSuccess) {
          context.go("/sign_in");
        }
        if (state is SignUpGoogleSuccess) {
          context.go("/dashboard");
        }
        if (state is SignUpError) {
          _showStateError(context, state);
        }
      }, builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Stack(children: [
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
                        firstText:
                            AppLocalizations.of(context)!.alreadyHaveAccount,
                        secondText: AppLocalizations.of(context)!.signIn,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.go("/sign_in")),
                  ],
                ),
              ),
              if (state is SignUpLoading) ...[const BuildLoadingCircle()]
            ]),
          ),
        );
      }),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        FormSignUp(
          emailController: _emailController,
          passwordController: _passwordController,
          confirmPasswordController: _confirmPasswordController,
          keyForm: _keyForm,
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
    if (_keyForm.currentState?.validate() ?? false) {
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
}
