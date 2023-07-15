import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/features/call/view/call_screen.dart';
import 'package:chatapp/src/helper/color_helper.dart';
import 'package:chatapp/src/helper/text_style_helper.dart';
import 'package:chatapp/src/helper/transition_screen_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarChatPage extends StatefulWidget
    implements PreferredSizeWidget {
  final UserModel currentUser;
  final UserModel guestUser;

  const AppBarChatPage(
      {super.key, required this.currentUser, required this.guestUser});

  @override
  State<StatefulWidget> createState() => _AppBarChatPageState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}

class _AppBarChatPageState extends State<AppBarChatPage> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actionsIconTheme: const IconThemeData(color: Colors.black, size: 40),
      toolbarHeight: 60,
      actions: [
        IconButton(
            onPressed: () async {
              TransitionHelper.nextScreen(
                  context,
                  CallScreen(
                      guestUser: widget.guestUser,
                      currentUser: widget.currentUser,
                      isVideoCall: false));
            },
            icon:
                Icon(Icons.call, color: ColorHelper.currentMessage, size: 35)),
        IconButton(
            onPressed: () {
              TransitionHelper.nextScreen(
                  context,
                  CallScreen(
                      guestUser: widget.guestUser,
                      currentUser: widget.currentUser,
                      isVideoCall: true));
            },
            icon: Icon(Icons.video_call_rounded,
                color: ColorHelper.currentMessage, size: 50)),
        const SizedBox(width: 10)
      ],
      leading: IconButton(
          onPressed: () {
            TransitionHelper.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 30, color: Colors.black)),
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
                Text(_getTheLastName(widget.guestUser.name),
                    style: TextStyleHelper.nameOfUserMessagePage),

                // online or offline status
                widget.guestUser.isOnline
                    ? Text(
                        'online',
                        style: TextStyle(
                            color: ColorHelper.onlineStatus, fontSize: 10),
                      )
                    : Text(
                        'offline',
                        style: TextStyle(
                            color: ColorHelper.offlineStatus, fontSize: 10),
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
