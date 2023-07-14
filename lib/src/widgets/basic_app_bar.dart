import 'package:flutter/material.dart';
import 'package:chatapp/src/helper/text_style_helper.dart';

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
  Size get preferredSize => const Size.fromHeight(50);
}

class _BasicAppBarState extends State<BasicAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actionsIconTheme: const IconThemeData(
        color: Colors.black,
        size: 40,
      ),
      leading: widget.leading,
      actions: widget.action,
      toolbarHeight: 60,
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        widget.title ?? 'FChat',
        style: TextStyleHelper.titleAppbar,
      ),
    );
  }
}
