import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chatapp/src/features/main_screen/bloc/main_page_bloc.dart';
import 'package:chatapp/src/helper/color_helper.dart';
import 'package:chatapp/src/l10n/app_localizations.dart';
import 'package:chatapp/src/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FloatingButton extends StatefulWidget {
  final Offset offset;
  final void Function(DragUpdateDetails)? onPanUpdate;

  const FloatingButton({
    super.key,
    required this.offset,
    required this.onPanUpdate,
  });

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [
          Positioned(
            left: widget.offset.dx,
            top: widget.offset.dy,
            child: GestureDetector(
              onPanUpdate: widget.onPanUpdate,
              child: FloatingActionButton(
                backgroundColor: ColorHelper.lightMain,
                onPressed: () {
                  _addChatUserDialog(context);
                },
                child: Icon(Icons.add_comment_rounded, size: 30.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addChatUser({required BuildContext context, required String checkId}) {
    context.read<MainPageBloc>().add(MainScreenAddChatUser(checkId: checkId));
  }

  void _addChatUserDialog(BuildContext context) {
    String input = '';

    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.TOPSLIDE,
      headerAnimationLoop: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: CustomTextFormField(
          maxLines: 1,
          onChanged: (value) => input = value,
          controller: null,
          hintText: AppLocalizations.of(context)!.enterID,
          keyboardType: TextInputType.number,
          prefixIcon: const Icon(Icons.code_sharp, color: Colors.blue),
        ),
      ),
      btnOkIcon: Icons.check,
      btnOkColor: Colors.blue,
      btnOkOnPress: () async {
        if (input.isNotEmpty) {
          _addChatUser(context: context, checkId: input);
        }
      },
    ).show();
  }
}
