import 'package:chatapp/src/router/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EditIconWidget extends StatelessWidget {
  const EditIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.go(RoutePaths.editProfilePage),
      icon: Icon(
        Icons.edit,
        size: 30.sp,
      ),
    );
  }
}
