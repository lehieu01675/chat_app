import 'package:chatapp/src/theme/color_theme.dart';
import 'package:chatapp/src/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/src/widgets/custom_border.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final Color backGroundColor = ColorTheme.gallery;
  final String? Function(String?)? validator;
  final Icon? prefixIcon;
  final IconButton? suffixIcon;
  final TextInputAction? textInputAction;
  final bool? autoFocus;
  final FocusNode? focusNode;
  final int? maxLines;
  final TextInputType keyboardType;
  final AutovalidateMode? autoValidateMode;
  final void Function(String)? onChanged;
  final String hintText;

  CustomTextFormField({
    super.key,
    required this.controller,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines,
    required this.keyboardType,
    this.autoValidateMode,
    required this.hintText,
    this.onChanged,
    this.focusNode,
    this.autoFocus,
    this.textInputAction,
  });

  factory CustomTextFormField.email({
    required TextEditingController controller,
    required String hintText,
    required TextInputType keyboardType,
    TextInputAction? textInputAction,
    bool? autoFocus,
    required AutovalidateMode autoValidateMode,
    String? Function(String?)? validator,
  }) {
    return CustomTextFormField(
      maxLines: 1,
      controller: controller,
      hintText: hintText,
      autoFocus: autoFocus,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autoValidateMode: autoValidateMode,
      validator: validator,
      suffixIcon: null,
      prefixIcon: const Icon(Icons.email),
    );
  }

  factory CustomTextFormField.password({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required TextInputType keyboardType,
    TextInputAction? textInputAction,
    required AutovalidateMode autoValidateMode,
    String? Function(String?)? validator,
  }) {
    return CustomTextFormField(
      maxLines: 1,
      controller: controller,
      hintText: hintText,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      autoValidateMode: autoValidateMode,
      validator: validator,
      prefixIcon: const Icon(Icons.password),
    );
  }

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscuteText = false;
  Icon? prefixIcon;

  @override
  initState() {
    super.initState();
    prefixIcon = widget.prefixIcon;
  }

  _onPressed() {
    setState(() {
      _obscuteText = !_obscuteText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomBorder(
      child: TextFormField(
        controller: widget.controller,
        maxLines: widget.maxLines,
        focusNode: widget.focusNode,
        obscureText: _obscuteText,
        autofocus: widget.autoFocus ?? false,
        validator: widget.validator,
        textInputAction: widget.textInputAction,
        style: FontTheme.mineShaft15W500Poppins,
        autovalidateMode: widget.autoValidateMode,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          errorStyle: FontTheme.red12W400Poppins,
          suffixIcon: (prefixIcon == const Icon(Icons.password))
              ? IconButton(
                  onPressed: () => _onPressed(),
                  icon: Icon(
                      _obscuteText ? Icons.visibility : Icons.visibility_off))
              : widget.suffixIcon,
          fillColor: ColorTheme.white,
          filled: true,
          hintText: widget.hintText,
          hintStyle: FontTheme.silverChalice15W400Roboto,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
          ),
        ),
      ),
    );
  }
}
