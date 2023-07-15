import 'package:chatapp/src/features/authentication/verify_OTP/bloc/verify_otp_bloc.dart';
import 'package:chatapp/src/l10n/app_localizations.dart';
import 'package:chatapp/src/router/route_paths.dart';
import 'package:chatapp/src/theme/color_theme.dart';
import 'package:chatapp/src/utils/dialog_util.dart';
import 'package:chatapp/src/widgets/background_image.dart';
import 'package:chatapp/src/widgets/custom_arrow_back.dart';
import 'package:chatapp/src/widgets/custom_button.dart';
import 'package:chatapp/src/widgets/slogan.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyOTPPage extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const VerifyOTPPage({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  State<VerifyOTPPage> createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {
  final _pinController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  String smsCode = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyOtpBloc(),
      child: BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
        listener: (context, state) {
          if (state is VerifyOTPSuccess) {
            context.go(RoutePaths.dashboard);
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
                    children: [
                      SizedBox(height: 50.h),
                      const CustomArrowBackIcon(),
                      SizedBox(height: 50.h),
                      SloganWidget(
                        slogan: AppLocalizations.of(context)!.sloganPhoneNumber,
                        title: AppLocalizations.of(context)!.verifyOTP,
                      ),
                      SizedBox(height: 20.h),
                      Pinput(
                        onChanged: ((value) {
                          smsCode = value;
                        }),
                        errorPinTheme: defaultPinTheme.copyBorderWith(
                          border: Border.all(color: Colors.redAccent),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: const Color.fromRGBO(243, 246, 249, 0),
                            borderRadius: BorderRadius.circular(19),
                            // ignore: prefer_const_constructors
                            border: Border.all(
                                color: const Color.fromRGBO(23, 171, 144, 1)),
                          ),
                        ),
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: const Color.fromRGBO(23, 171, 144, 1)),
                          ),
                        ),
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 22,
                              height: 1,
                              color: const Color.fromRGBO(23, 171, 144, 1),
                            ),
                          ],
                        ),
                        androidSmsAutofillMethod:
                            AndroidSmsAutofillMethod.smsUserConsentApi,
                        listenForMultipleSmsOnAndroid: true,
                        defaultPinTheme: defaultPinTheme,
                        length: 6,
                        focusNode: _pinPutFocusNode,
                        controller: _pinController,
                        pinAnimationType: PinAnimationType.fade,
                      ),
                      SizedBox(height: 10.h),
                      CustomButton.curiousBlue(
                        label: AppLocalizations.of(context)!.send,
                        onPress: () => _send(context),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: ColorTheme.curiousBlue),
    ),
  );

  void _send(BuildContext context) {
    if (smsCode.length == 6) {
      _verifyOtp(context: context, verificationId: widget.verificationId);
    }
  }

  void _verifyOtp({
    required BuildContext context,
    required String verificationId,
  }) {
    context.read<VerifyOtpBloc>().add(VerifyOTP(
        smsCode: smsCode,
        verificationId: widget.verificationId,
        onError: () => _showVerityOTPValidation(context)));
  }

  void _showVerityOTPValidation(BuildContext context) {
    DialogUtil.showException(
      title: AppLocalizations.of(context)!.verifyFailed,
      context: context,
      onPressedOK: () {},
      message: AppLocalizations.of(context)!.otpIncorrect,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pinController.dispose();
  }
}
