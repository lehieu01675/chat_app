import 'package:chatapp/src/constant/text_cons.dart';
import 'package:chatapp/src/l10n/app_localizations.dart';
import 'package:chatapp/src/utils/regex_util.dart';
import 'package:chatapp/src/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class FormPhoneNumber extends StatelessWidget {
  final GlobalKey<FormState> keyForm;
  final TextEditingController phoneNumberController;

  const FormPhoneNumber({
    super.key,
    required this.phoneNumberController,
    required this.keyForm,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: keyForm,
      child: CustomTextFormField(
        prefixIcon: const Icon(Icons.phone),
        controller: phoneNumberController,
        hintText: TextConstant.phoneNumberExample,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (phoneNumber) =>
            _phoneNumberValidation(context, phoneNumber),
      ),
    );
  }

  String? _phoneNumberValidation(
    BuildContext context,
    String? phoneNumber,
  ) {
    if (phoneNumber == null ||
        !RegexUtil.phoneNumberValid(phoneNumber: phoneNumber)) {
      return AppLocalizations.of(context)!.phoneNumberValid;
    } else {
      return null;
    }
  }
}
