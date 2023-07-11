import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chatapp/src/data/repositories/phone_repo.dart';
import 'package:chatapp/src/data/repositories/user_repo.dart';
import 'package:chatapp/src/features/authentication/phong_number/bloc/phone_sign_in_bloc.dart';
import 'package:chatapp/src/features/authentication/verify_OTP/bloc/verify_otp_bloc.dart';
import 'package:chatapp/src/utils/dialog_util.dart';
import 'package:chatapp/src/helper/size_helper.dart';
import 'package:chatapp/src/helper/text_style_helper.dart';
import 'package:chatapp/src/lay_out/responsive_layout.dart';
import 'package:chatapp/src/widgets/custom_button.dart';
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
  String _notificationOtp = '';
  final String _title = 'OTP Verification';

  @override
  void initState() {
    super.initState();
    _notificationOtp =
        'Verification code has been sent to phone number: ${widget.phoneNumber}. This code will take effect within 90 seconds.';
  }

  // TODO: tach bloc => state
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => VerifyOtpBloc(
          phoneRepository: PhoneRepository(),
          userRepository: UserRepository(),
        ),
        child: BlocListener<PhoneSignInBloc, PhoneSignInState>(
            listener: (context, state) {
          if (state is VerifyOtpError) {}
        }, child: BlocBuilder<PhoneSignInBloc, PhoneSignInState>(
                builder: (context, state) {
          if (state is PhoneSignInLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      context.sizedBox(height: SizeHelper.topWithSlogan * 2),
                      Center(
                          child:
                              Text(_title, style: TextStyleHelper.bigSlogan)),
                      const SizedBox(height: 5),
                      Center(
                          child: Text(_notificationOtp,
                              textAlign: TextAlign.center,
                              style: TextStyleHelper.dontHavaAccount)),
                      const SizedBox(height: 20),
                      Center(
                          child: Pinput(
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
                      )),
                      context.sizedBox(
                          height: SizeHelper.textFormFieldWithButton),
                      CustomButton.curiousBlue(
                          label: 'Xác nhận',
                          onPress: () {
                            if (smsCode.length == 6) {
                              _verifyOtp(
                                  context: context,
                                  verificationId: widget.verificationId);
                            } else {}
                          }),
                    ],
                  ),
                ),
              ]),
            );
          }
        })),
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
      border: Border.all(color: const Color.fromRGBO(23, 171, 144, 0.4)),
    ),
  );

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
    DialogUtil.showDiaLog(
        title: 'Verification failed',
        context: context,
        onPressedOK: () {},
        message: 'The verification code is incorrect',
        colorOkButton: Colors.red,
        dialogType: DialogType.ERROR,
        iconData: Icons.cancel);
  }
}
