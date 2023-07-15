import 'package:chatapp/src/constant/text_cons.dart';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/data/repositories/list_message_repo.dart';
import 'package:chatapp/src/features/profile/page/profile_page.dart';
import 'package:chatapp/src/l10n/app_localizations.dart';
import 'package:chatapp/src/router/route_paths.dart';
import 'package:chatapp/src/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

class CustomChatCard extends StatelessWidget {
  final UserModel guestUser;
  final UserModel currentUser;
  final Widget? trailing;
  final Widget? subTitle;
  final bool isChatPage;
  final void Function(BuildContext)? onPressed;

  final _currentUserCache = Hive.box(TextConstant.currentUserPath);

  CustomChatCard({
    super.key,
    required this.guestUser,
    required this.currentUser,
    this.trailing,
    this.subTitle,
    required this.isChatPage,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            _buildSlidableAction(context),
          ],
        ),
        child: _card(context: context, size: size));
  }

  Widget _buildSlidableAction(BuildContext context) {
    return SlidableAction(
      autoClose: true,
      borderRadius: BorderRadius.all(Radius.circular(10.r)),
      onPressed: onPressed,
      backgroundColor: const Color(0xFFFE4A49),
      foregroundColor: Colors.white,
      icon: Icons.delete,
      label: AppLocalizations.of(context)!.delete,
    );
  }

  Widget _card({required BuildContext context, required Size size}) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          _currentUserCache.put('guest_user', guestUser);
          // get id of conversation
          ListMessageRepository.conversationId = guestUser.id;

          isChatPage ? context.go(RoutePaths.chatPage) : () {};
        },
        child: ListTile(
          subtitle: subTitle,
          title: Text(
            guestUser.name,
            style: const TextStyle(fontSize: 20),
            maxLines: 1,
          ),
          trailing: trailing,
          leading: InkWell(
              onTap: () => showDialog(
                  context: context, builder: (_) => const ProfilePage()),
              child: CustomAvatar(imageUrl: guestUser.image)),
        ),
      ),
    );
  }
}
