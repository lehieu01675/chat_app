import 'package:chatapp/src/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SloganWidget extends StatelessWidget {
  final String title;
  final String slogan;

  const SloganWidget({
    super.key,
    required this.title,
    required this.slogan,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: FontTheme.mineShaft30W600Poppins,
          ),
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              slogan,
              maxLines: 3,
              textAlign: TextAlign.center,
              style: FontTheme.mineShaft15W500RobotoMono,
            ),
          )
        ],
      ),
    );
  }
}
