import 'package:chatapp/src/features/my_app/bloc/my_app_bloc.dart';
import 'package:chatapp/src/l10n/app_localizations.dart';
import 'package:chatapp/src/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextButton extends StatelessWidget {
  final void Function() onPressed;
  final String title;

  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: FontTheme.mineShaft15W400UnderlinePoppins,
      ),
    );
  }

  factory CustomTextButton.changeLanguage(BuildContext context) {
    return CustomTextButton(
      onPressed: () {
        BlocProvider.of<MyAppBloc>(context).add(MyAppUpdateLanguage());
      },
      title: AppLocalizations.of(context)!.changeLanguage,
    );
  }
}
