import 'package:chatapp/src/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FontTheme {
  static TextStyle silverChalice15W400Roboto = GoogleFonts.roboto(
    color: ColorTheme.silverChalice,
    fontSize: 15.sp,
  );
  static TextStyle white20W700Poppins = GoogleFonts.roboto(
    color: ColorTheme.white,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle white25W600Poppins = GoogleFonts.roboto(
    color: ColorTheme.white,
    fontSize: 25.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle mineShaft15W500Poppins = GoogleFonts.poppins(
    color: ColorTheme.mineShaft,
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle mineShaft30W600Poppins = GoogleFonts.poppins(
    color: ColorTheme.mineShaft,
    fontSize: 30.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle mineShaft15W500RobotoMono = GoogleFonts.robotoMono(
    color: ColorTheme.mineShaft,
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle mineShaft15W400UnderlinePoppins = GoogleFonts.poppins(
    color: ColorTheme.mineShaft,
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.underline,
  );

  static TextStyle curiousBlue20W500UnderlinePoppins = GoogleFonts.poppins(
    color: ColorTheme.curiousBlue,
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline,
  );

  static TextStyle red12W400Poppins = GoogleFonts.poppins(
    color: ColorTheme.red,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );
}
