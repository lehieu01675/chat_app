import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/features/main_screen/bloc/main_page_bloc.dart';
import 'package:chatapp/src/features/main_screen/widgets/build_online_dot.dart';
import 'package:chatapp/src/widgets/custom_chat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListChatCardWidget extends StatelessWidget {
  final List<UserModel> listChatUser;
  final UserModel currentUser;

  const ListChatCardWidget({
    super.key,
    required this.listChatUser,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: listChatUser.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final guestUser = listChatUser[index];
          return CustomChatCard(
            onPressed: (context) => _removeChatUser(context, guestUser),
            subTitle: Text(guestUser.checkId),
            isChatPage: true,
            guestUser: guestUser,
            currentUser: currentUser,
            trailing:
                guestUser.isOnline ? const BuildOnLineDot() : const SizedBox(),
          );
        },
      ),
    );
  }

  void _removeChatUser(BuildContext context, UserModel guestUser) {
    context
        .read<MainPageBloc>()
        .add(MainScreenRemoveChatUser(id: guestUser.id));
  }
}
