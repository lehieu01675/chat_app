import 'package:chatapp/src/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomArrowBackIcon extends StatelessWidget {
  const CustomArrowBackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () => context.pop(true),
          icon: Icon(
            Icons.arrow_back_ios,
            color: ColorTheme.mineShaft,
            size: 40.sp,
          ),
        ),
      ],
    );
  }
}
