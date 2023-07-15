import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarEditProfile extends StatelessWidget {
  final Widget image;
  final void Function() pickImage;

  const AvatarEditProfile({
    super.key,
    required this.pickImage,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          shape: const CircleBorder()),
      onPressed: pickImage,
      child: Container(
        width: 150.w,
        height: 150.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100.r),
          child: image,
        ),
      ),
    );
  }
}
