import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chatapp/src/theme/color_theme.dart';
import 'package:flutter/material.dart';

class DialogUtil {
  static void showDiaLog({
    required BuildContext context,
    required String title,
    required DialogType dialogType,
    required String message,
    required void Function() onPressedOK,
    required IconData iconData,
    required Color colorOkButton,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.TOPSLIDE,
      headerAnimationLoop: true,
      title: title,
      desc: message,
      btnOkOnPress: () {
        onPressedOK();
      },
      btnOkIcon: iconData,
      btnOkColor: colorOkButton,
    ).show();
  }

  static void showSuccess({
    required BuildContext context,
    required String title,
    required String message,
    required void Function() onPressedOK,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.TOPSLIDE,
      headerAnimationLoop: true,
      title: title,
      desc: message,
      btnOkOnPress: () {
        onPressedOK();
      },
      btnOkColor: ColorTheme.curiousBlue,
    ).show();
  }

  static void showException(
      {required BuildContext context,
      required String title,
      required String message,
      required void Function() onPressedOK}) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.TOPSLIDE,
      headerAnimationLoop: true,
      title: title,
      desc: message.replaceAll('Exception: ', ""),
      btnOkOnPress: () {
        onPressedOK();
      },
      btnOkColor: ColorTheme.curiousBlue,
    ).show();
  }

  static void showBothOkAndCancel(
      {required String okText,
      required String cancelText,
      required String body,
      required IconData okIcon,
      required IconData cancelIcon,
      required BuildContext context,
      void Function()? okOnPress,
      void Function()? cancelOnPress}) {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.QUESTION,
            animType: AnimType.TOPSLIDE,
            headerAnimationLoop: true,
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(body)),
            btnOkIcon: okIcon,
            btnOkColor: Colors.blue,
            btnOkText: okText,
            btnCancelText: cancelText,
            btnCancelColor: const Color.fromARGB(255, 23, 190, 149),
            btnCancelIcon: cancelIcon,
            btnOkOnPress: okOnPress,
            btnCancelOnPress: cancelOnPress)
        .show();
  }
}
