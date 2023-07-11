import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSVGImage extends StatelessWidget {
  final String svgPath;
  final Color? color;
  final double? width;
  final double? height;
  final void Function()? onTap;

  const CustomSVGImage({
    Key? key,
    required this.svgPath,
    this.color,
    this.width,
    this.height,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        svgPath,
        width: width ?? 50.w,
        height: height ?? 50.w,
        fit: BoxFit.cover,
      ),
    );
  }
}
