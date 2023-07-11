import 'package:chatapp/src/theme/color_theme.dart';
import 'package:chatapp/src/theme/font_theme.dart';
import 'package:chatapp/src/widgets/custom_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final double? width;
  final double? height;
  final VoidCallback? onPress;
  final Color? backgroundColor;
  final TextStyle textStyleText;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPress,
    required this.backgroundColor,
    required this.textStyleText,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBorder(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Text(label, style: textStyleText),
        ),
      ),
    );
  }

  factory CustomButton.curiousBlue({
    required VoidCallback? onPress,
    required String label,
  }) {
    return CustomButton(
      label: label,
      onPress: onPress,
      width: ScreenUtil().screenWidth,
      height: 70.h,
      backgroundColor: ColorTheme.curiousBlue,
      textStyleText: FontTheme.white20W700Poppins,
    );
  }

}
