import 'package:chatapp/src/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackgroundProfilePage extends StatelessWidget {
  const BackgroundProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenHeight * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
        color: ColorTheme.white,
      ),
    );
  }
}
