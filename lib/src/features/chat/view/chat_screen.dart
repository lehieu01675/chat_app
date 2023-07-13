import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/features/main_screen/bloc/main_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatapp/src/widgets/custom_message_box.dart';
import 'package:chatapp/src/features/chat/bloc/chat_bloc.dart';
import 'package:chatapp/src/features/chat/build_widgets/build_app_bar_chat_screen.dart';
import 'package:chatapp/src/features/chat/build_widgets/build_message_input.dart';
import 'package:chatapp/src/models/message_model.dart';
import 'package:chatapp/src/features/chat/repositories/chat_repo.dart';

class ChatScreen extends StatefulWidget {
  final UserModel guestUser;
  final UserModel currentUser;

  const ChatScreen({
    super.key,
    required this.currentUser,
    required this.guestUser,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  List<MessageModel>? _listMessage;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainPageBloc(),
      child: Scaffold(
          appBar: BuildAppBarChatScreen(
            currentUser: widget.currentUser,
            guestUser: widget.guestUser,
          ),
          body: BlocProvider(
            create: (context) => ChatBloc(chatRepository: ChatRepository()),
            child: BlocListener<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state.status == ChatStatus.loading) {
                  const Center(child: CircularProgressIndicator());
                }
              },
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state.listMessage != []) {
                    _listMessage = state.listMessage;
                    return Stack(children: [
                      // BackgroundLogin(
                      //     size: size, imagePath: ImageHelper.backGroundOfLogin),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  reverse: true,
                                  itemCount: _listMessage!.length,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return CustomMessageCard(
                                        messageModel: _listMessage![index],
                                        isCurrentUser: (widget.currentUser.id ==
                                            _listMessage![index].fromId));
                                  }),
                            ),
                            // check process when send image
                            (state.status == ChatStatus.imageLoading)
                                ? Container()
                                // Lottie.asset(ImageHelper.imageLoading,
                                //         width: 55, height: 55)
                                : Container(),
                            const SizedBox(height: 10),
                            // message input
                            BuildMessageInput(
                              currentUser: widget.currentUser,
                              guestUser: widget.guestUser,
                              listMessage: _listMessage!,
                              messageController: _messageController,
                            ),
                            const SizedBox(height: 10),
                          ]),
                    ]);
                  } else {
                    return const Center(child: Text('Say hello ✌️'));
                  }
                },
              ),
            ),
          )),
    );
  }
}
