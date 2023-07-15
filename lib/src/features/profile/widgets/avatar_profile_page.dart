import 'package:chatapp/src/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarProfilePage extends StatelessWidget {
  final String avatarPath;

  const AvatarProfilePage({
    super.key,
    required this.avatarPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: CustomAvatar(
        imageUrl: avatarPath,
        radius: 100.r,
      ),
    );
  }
}
