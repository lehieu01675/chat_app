import 'package:chatapp/src/constant/text_cons.dart';
import 'package:chatapp/src/l10n/app_localizations.dart';
import 'package:chatapp/src/utils/regex_util.dart';
import 'package:chatapp/src/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormSignUp extends StatelessWidget {
  final GlobalKey<FormState> keyForm;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const FormSignUp({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.keyForm,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: keyForm,
      child: Column(
        children: [
          CustomTextFormField.email(
            controller: emailController,
            autoFocus: true,
            hintText: TextConstant.emailExample,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            validator: (email) => _emailValidation(context, email),
          ),
          SizedBox(height: 10.h),
          CustomTextFormField.password(
            obscureText: true,
            controller: passwordController,
            hintText: TextConstant.passwordExample,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            validator: (password) => _passwordValidation(context, password),
          ),
          SizedBox(height: 10.h),
          CustomTextFormField.password(
              obscureText: true,
              controller: confirmPasswordController,
              hintText: TextConstant.passwordExample,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (confirmPassword) => _confirmPasswordValidation(
                    context,
                    confirmPassword,
                    passwordController.text,
                  )),
        ],
      ),
    );
  }

  // password have to more than 6 characters
  String? _passwordValidation(BuildContext context, String? password) {
    if (password == null ||
        !RegexUtil.passwordValid(
          context: context,
          password: password,
        )) {
      return AppLocalizations.of(context)!.passwordValid;
    } else {
      return null;
    }
  }

  String? _confirmPasswordValidation(
    BuildContext context,
    String? confirmPassword,
    String? password,
  ) {
    if (confirmPassword == null ||
        !RegexUtil.passwordValid(context: context, password: confirmPassword)) {
      return AppLocalizations.of(context)!.passwordValid;
    } else if (!RegexUtil.confirmPasswordValid(
      context: context,
      confirmPassword: confirmPassword,
      password: password ?? "",
    )) {
      return AppLocalizations.of(context)!.confirmPasswordValid;
    } else {
      return null;
    }
  }

// email have to contain @gmail.com
  String? _emailValidation(BuildContext context, String? email) {
    if (email == null ||
        !RegexUtil.emailValid(context: context, email: email)) {
      return AppLocalizations.of(context)!.emailValid;
    } else {
      return null;
    }
  }
}
