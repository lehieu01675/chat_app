import 'package:chatapp/src/l10n/app_localizations.dart';
import 'package:chatapp/src/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrSignInWithWidget extends StatelessWidget {
  const OrSignInWithWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Divider(color: Colors.black, thickness: 0.5.h)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              AppLocalizations.of(context)!.orSignInWith,
              style: FontTheme.silverChalice15W400Roboto,
            ),
          ),
          Expanded(child: Divider(color: Colors.black, thickness: 0.5.h)),
        ],
      ),
    );
  }
}
