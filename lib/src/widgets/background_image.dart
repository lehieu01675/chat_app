import 'package:chatapp/src/theme/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackgroundImageWidget extends StatelessWidget {
  const BackgroundImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Assets.images.background.image(
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenHeight,
    );
  }
}
