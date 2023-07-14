import 'package:chatapp/src/constant/text_cons.dart';
import 'package:chatapp/src/features/authentication/phong_number/bloc/phone_sign_in_bloc.dart';
import 'package:chatapp/src/features/authentication/phong_number/widgets/form_phone_number.dart';
import 'package:chatapp/src/l10n/app_localizations.dart';
import 'package:chatapp/src/router/route_paths.dart';
import 'package:chatapp/src/utils/dialog_util.dart';
import 'package:chatapp/src/utils/regex_util.dart';
import 'package:chatapp/src/widgets/background_image.dart';
import 'package:chatapp/src/widgets/build_loading_circle.dart';
import 'package:chatapp/src/widgets/custom_arrow_back.dart';
import 'package:chatapp/src/widgets/custom_button.dart';
import 'package:chatapp/src/widgets/slogan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PhoneSignInPage extends StatefulWidget {
  const PhoneSignInPage({super.key});

  @override
  State<PhoneSignInPage> createState() => _PhoneSignInPageState();
}

class _PhoneSignInPageState extends State<PhoneSignInPage> {
  final _keyForm = GlobalKey<FormState>();

  final _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => PhoneSignInBloc(),
        child: BlocConsumer<PhoneSignInBloc, PhoneSignInState>(
          listener: (context, state) {
            if (state is PhoneSignInSendOTPSuccess) {}
            if (state is PhoneSignInError) {
              _showStateError(context, state);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  const BackgroundImageWidget(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        SizedBox(height: 50.h),
                        const CustomArrowBackIcon(),
                        SizedBox(height: 50.h),
                        SloganWidget(
                          slogan:
                              AppLocalizations.of(context)!.sloganPhoneNumber,
                          title: AppLocalizations.of(context)!.phoneNumber,
                        ),
                        SizedBox(height: 20.h),
                        FormPhoneNumber(
                          phoneNumberController: _phoneNumberController,
                          keyForm: _keyForm,
                        ),
                        SizedBox(height: 10.h),
                        CustomButton.curiousBlue(
                          label: AppLocalizations.of(context)!.send,
                          onPress: () => _submitPhoneNumber(context),
                        ),
                      ],
                    ),
                  ),
                  if (state is PhoneSignInLoading) ...[
                    const BuildLoadingCircle()
                  ]
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _submitPhoneNumber(BuildContext context) async {
    if (RegexUtil.phoneNumberValid(
        phoneNumber: _phoneNumberController.text.trim())) {
      _sentOTP(context);
    } else {
      _phoneValidation(context);
    }
  }

  void _phoneValidation(BuildContext context) {
    DialogUtil.showException(
      onPressedOK: () {},
      title: AppLocalizations.of(context)!.sendFailed,
      context: context,
      message: AppLocalizations.of(context)!.phoneNumberValid,
    );
  }

  void _naviToVerityOtpPage({
    required BuildContext context,
    required String verificationId,
    required String phoneNumber,
  }) {
    GoRouter.of(context).go(
      RoutePaths.verifyOtp,
      extra: {
        TextConstant.verificationID: verificationId,
        TextConstant.phoneNumber: phoneNumber,
      },
    );
  }

  void _sentOTP(BuildContext context) {
    context.read<PhoneSignInBloc>().add(
          PhoneSignInSendOTP(
            phoneNumber: _phoneNumberController.text.substring(1),
            pushToOtp: (String verificationId) {
              final phoneNumber = _phoneNumberController.text.trim();
              _naviToVerityOtpPage(
                context: context,
                verificationId: verificationId,
                phoneNumber: phoneNumber,
              );
            },
          ),
        );
  }

  void _showStateError(BuildContext context, PhoneSignInError state) {
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
    _phoneNumberController.dispose();
  }
}
