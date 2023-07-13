import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:chatapp/src/features/chat/repositories/chat_repo.dart';
import 'package:chatapp/src/features/chat/view/chat_screen.dart';
import 'package:chatapp/src/features/profile/view/profile_screen.dart';
import 'package:chatapp/src/helper/size_helper.dart';
import 'package:chatapp/src/helper/transition_screen_helper.dart';
import 'package:chatapp/src/lay_out/responsive_layout.dart';

class CustomChatCard extends StatelessWidget {
  final UserModel guestUser;
  final UserModel currentUser;
  final Widget? trailing;
  final Widget? subTitle;
  final bool isChatPage;
  final void Function(BuildContext)? onPressed;

  const CustomChatCard(
      {super.key,
      required this.guestUser,
      required this.currentUser,
      this.trailing,
      this.subTitle,
      required this.isChatPage,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              autoClose: true,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              onPressed: onPressed,
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: _card(context: context, size: size));
  }

  Widget _card({required BuildContext context, required Size size}) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          // get the id of guestUser
          // because conversationId need a guestUser's id
          // when listen using contructor i can't set the guestUser to contructor
          ChatRepository.conversationId = guestUser.id;

          isChatPage
              ? TransitionHelper.nextScreen(
                  context,
                  ChatScreen(
                    currentUser: currentUser,
                    guestUser: guestUser,
                  ))
              : () {};
        },
        child: ListTile(
          subtitle: subTitle,
          // show name of chat user
          title: Text(
            guestUser.name,
            style: const TextStyle(fontSize: 20),
            maxLines: 1,
          ),
          trailing: trailing,
          leading: InkWell(
            // show profile page of chat user
            onTap: () => showDialog(
                context: context,
                builder: (_) => ProfilePage(currentUser: guestUser)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size.height * .05),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                width: context.sizeWidth(SizeHelper.widthHeightAvatar),
                height: context.sizeWidth(SizeHelper.widthHeightAvatar),
                imageUrl: guestUser.image,
                errorWidget: (context, url, error) =>
                    const CircleAvatar(child: Icon(CupertinoIcons.person)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
