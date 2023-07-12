import 'package:chatapp/src/constant/text_cons.dart';
import 'package:chatapp/src/l10n/app_localizations.dart';
import 'package:chatapp/src/utils/regex_util.dart';
import 'package:chatapp/src/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class FormForgotPassword extends StatelessWidget {
  final GlobalKey<FormState> keyForm;
  final TextEditingController emailController;

  const FormForgotPassword({
    super.key,
    required this.emailController,
    required this.keyForm,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: keyForm,
      child: CustomTextFormField.email(
        controller: emailController,
        hintText: TextConstant.emailExample,
        autoFocus: true,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.emailAddress,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (email) => _emailValidation(context, email),
      ),
    );
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
