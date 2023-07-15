import 'package:chatapp/src/features/dash_board/bloc/dashboard_bloc.dart';
import 'package:chatapp/src/features/profile/bloc/sign_out_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignOutIconWidget extends StatelessWidget {
  const SignOutIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _signOut(context: context),
      icon: Icon(
        Icons.logout_outlined,
        size: 30.sp,
      ),
    );
  }

  void _updateStatus(BuildContext context) {
    context
        .read<DashboardBloc>()
        .add(const DashboardUpdateUserStatus(status: false));
  }

  void _signOut({required BuildContext context}) {
    _updateStatus(context);
    context.read<SignOutBloc>().add(SignOutAccount());
  }
}
