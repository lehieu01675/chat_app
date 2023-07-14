import 'package:chatapp/src/constant/text_cons.dart';
import 'package:chatapp/src/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasicAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? leading;
  final List<Widget>? action;
  final String? title;

  const BasicAppBar({
    super.key,
    this.leading,
    this.action,
    this.title,
  });

  @override
  State<StatefulWidget> createState() => _BasicAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}

class _BasicAppBarState extends State<BasicAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: widget.leading,
      actions: widget.action,
      toolbarHeight: 100.h,
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        widget.title ?? TextConstant.fChat,
        style: FontTheme.mineShaft30W500Poppins,
      ),
    );
  }
}
