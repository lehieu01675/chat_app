import 'package:chatapp/src/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildLoadingCircle extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;

  const BuildLoadingCircle({
    super.key,
    this.width,
    this.height, this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenHeight,
      color: color ?? ColorTheme.silverChalice.withOpacity(0.7),
      child: CircularProgressIndicator(
        color: ColorTheme.curiousBlue,
      ),
    );
  }
}
