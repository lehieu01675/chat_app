import 'package:chatapp/src/features/authentication/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:chatapp/src/features/authentication/forgot_password/widgets/form_forgot_password.dart';
import 'package:chatapp/src/l10n/app_localizations.dart';
import 'package:chatapp/src/utils/dialog_util.dart';
import 'package:chatapp/src/widgets/background_image.dart';
import 'package:chatapp/src/widgets/build_loading_circle.dart';
import 'package:chatapp/src/widgets/custom_arrow_back.dart';
import 'package:chatapp/src/widgets/custom_button.dart';
import 'package:chatapp/src/widgets/slogan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  static final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(),
      child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSendSuccess) {
            DialogUtil.showSuccess(
              context: context,
              title: 'Sent email',
              message:
                  'We have sent you an email. Click to link to reset your password',
              onPressedOK: () => context.pop(true),
            );
          }
          if (state is ForgotPasswordError) {
            _showStateError(context, state);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Stack(children: [
                const BackgroundImageWidget(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 50.h),
                      const CustomArrowBackIcon(),
                      SizedBox(height: 50.h),
                      SloganWidget(
                        slogan:
                            AppLocalizations.of(context)!.sloganForgotPassword,
                        title: AppLocalizations.of(context)!.forgotPassword,
                      ),
                      SizedBox(height: 20.h),
                      FormForgotPassword(
                        emailController: _emailController,
                        keyForm: _keyForm,
                      ),
                      SizedBox(height: 10.h),
                      CustomButton.curiousBlue(
                        onPress: () => _forgotPassword(context),
                        label: AppLocalizations.of(context)!.send,
                      )
                    ],
                  ),
                ),
                if (state is ForgotPasswordLoading) ...[
                  const BuildLoadingCircle()
                ]
              ]),
            ),
          );
        },
      ),
    );
  }

  void _forgotPassword(BuildContext context) {
    if (_keyForm.currentState?.validate() ?? false) {
      context
          .read<ForgotPasswordBloc>()
          .add(ForgotPasswordSendEmail(email: _emailController.text.trim()));
    }
  }

  void _showStateError(BuildContext context, ForgotPasswordError state) {
    DialogUtil.showException(
      context: context,
      onPressedOK: () {},
      title: AppLocalizations.of(context)!.signInFailed,
      message: state.message,
    );
  }
}
