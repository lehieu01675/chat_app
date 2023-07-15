import 'package:chatapp/src/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAvatar extends StatelessWidget {
  final double? width, height;
  final double? radius;
  final String imageUrl;

  const CustomAvatar({
    super.key,
    this.width,
    this.height,
    required this.imageUrl, this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular( radius ?? 50.r),
      child: CustomNetworkImage(
        width: width ?? 55.w,
        height: height ?? 55.w,
        imageUrl: imageUrl,
      ),
    );
  }
}
