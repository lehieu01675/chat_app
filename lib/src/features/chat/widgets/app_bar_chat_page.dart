import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/router/route_paths.dart';
import 'package:chatapp/src/theme/color_theme.dart';
import 'package:chatapp/src/theme/font_theme.dart';
import 'package:chatapp/src/widgets/custom_arrow_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AppBarChatPage extends StatefulWidget implements PreferredSizeWidget {
  final UserModel currentUser;
  final UserModel guestUser;

  const AppBarChatPage(
      {super.key, required this.currentUser, required this.guestUser});

  @override
  State<StatefulWidget> createState() => _AppBarChatPageState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(100.h);
}

class _AppBarChatPageState extends State<AppBarChatPage> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actionsIconTheme: const IconThemeData(color: Colors.black, size: 40),
      toolbarHeight: 100.h,
      actions: [
        IconButton(
            onPressed: () async {
              context.go("${RoutePaths.callPagePath}?isVideoCall=false");
            },
            icon: Icon(Icons.call, color: ColorTheme.curiousBlue, size: 35)),
        IconButton(
            onPressed: () {
              context.go("${RoutePaths.callPagePath}?isVideoCall=true");
            },
            icon: Icon(
              Icons.video_call_rounded,
              color: ColorTheme.curiousBlue,
              size: 50,
            )),
        const SizedBox(width: 10)
      ],
      leading: const CustomArrowBackIcon(),
      elevation: 0,
      backgroundColor: Colors.transparent,
      leadingWidth: 50,
      title: InkWell(
        onTap: () {},
        child: Row(children: [
          Container(
            width: 45.w,
            height: 45.w,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: widget.guestUser.image,
                errorWidget: (context, url, error) => const Text('data'),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // name guest user
                Text(
                  _getTheLastName(widget.guestUser.name),
                  style: FontTheme.mineShaft15W500RobotoMono,
                ),

                // online or offline status
                widget.guestUser.isOnline
                    ? Text(
                        'online',
                        style: TextStyle(
                          color: ColorTheme.curiousBlue,
                          fontSize: 10,
                        ),
                      )
                    : Text(
                        'offline',
                        style: TextStyle(
                            color: ColorTheme.silverChalice, fontSize: 10),
                      ),
              ]),
        ]),
      ),
    );
  }

  String _getTheLastName(String fullName) {
    if (!fullName.contains(' ')) {
      return _getNameInLimit(fullName);
    } else {
      List<String> cacTu = fullName.split(' ');
      String lastName = cacTu.sublist(cacTu.length - 2).join(' ');
      return _getNameInLimit(lastName);
    }
  }

  String _getNameInLimit(String name) {
    if (name.length > 7) {
      return '${name.substring(0, 7)}...';
    } else {
      return name;
    }
  }
}
