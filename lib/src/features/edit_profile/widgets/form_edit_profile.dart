import 'package:chatapp/src/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormEditProfile extends StatelessWidget {
  final GlobalKey<FormState> keyForm;
  final TextEditingController nameController;
  final TextEditingController aboutController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final String currentName;
  final String currentAbout;
  final String currentEmail;
  final String currentPhoneNumber;

  const FormEditProfile({
    super.key,
    required this.nameController,
    required this.aboutController,
    required this.emailController,
    required this.phoneNumberController,
    required this.currentName,
    required this.currentAbout,
    required this.currentEmail,
    required this.currentPhoneNumber,
    required this.keyForm,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: keyForm,
      child: Column(
        children: [
          CustomTextFormField(
              controller: nameController,
              prefixIcon: const Icon(Icons.text_fields_sharp),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              hintText: 'Name: $currentName'),
          SizedBox(height: 10.h),
          CustomTextFormField(
              controller: aboutController,
              prefixIcon: const Icon(Icons.headphones_battery_sharp),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              hintText: 'Introduce: $currentAbout'),
          SizedBox(height: 10.h),
          CustomTextFormField(
              controller: emailController,
              prefixIcon: const Icon(Icons.email),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              hintText: 'Email: $currentEmail'),
          SizedBox(height: 10.h),
          CustomTextFormField(
              controller: phoneNumberController,
              prefixIcon: const Icon(Icons.phone),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              hintText: 'Phone: $currentPhoneNumber'),
        ],
      ),
    );
  }
}
