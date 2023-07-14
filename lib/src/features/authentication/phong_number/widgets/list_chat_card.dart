import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/features/main_screen/bloc/main_page_bloc.dart';
import 'package:chatapp/src/features/main_screen/widgets/build_online_dot.dart';
import 'package:chatapp/src/widgets/custom_chat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return ListView.builder(
      shrinkWrap: true,
      reverse: true,
      itemCount: listChatUser.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return CustomChatCard(
          onPressed: (context) {
            context
                .read<MainPageBloc>()
                .add(MainScreenRemoveChatUser(id: listChatUser[index].id));
          },
          trailing: listChatUser[index].isOnline
              ? const BuildOnLineDot()
              : const Text(''),
          subTitle: Text(
            listChatUser[index].checkId,
            maxLines: 1,
          ),
          isChatPage: true,
          guestUser: listChatUser[index],
          currentUser: currentUser,
        );
      },
    );
  }
}
