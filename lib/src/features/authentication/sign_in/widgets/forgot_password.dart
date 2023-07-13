import 'package:chatapp/src/l10n/app_localizations.dart';
import 'package:chatapp/src/router/app_pages.dart';
import 'package:chatapp/src/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            child: Text(
              AppLocalizations.of(context)!.forgotPassword,
              style: FontTheme.mineShaft15W400UnderlinePoppins,
            ),
            onPressed: () => context.go(RoutePaths.forgotPassword)),
      ],
    );
  }
}
