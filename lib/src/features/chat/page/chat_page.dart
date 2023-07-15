import 'package:chatapp/src/constant/text_cons.dart';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/features/chat/widgets/app_bar_chat_page.dart';
import 'package:chatapp/src/features/chat/widgets/message_input.dart';
import 'package:chatapp/src/features/main_screen/bloc/main_page_bloc.dart';
import 'package:chatapp/src/theme/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatapp/src/widgets/custom_message_box.dart';
import 'package:chatapp/src/features/chat/bloc/chat_bloc.dart';
import 'package:chatapp/src/data/models/message_model.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageController = TextEditingController();
  List<MessageModel>? _listMessage;
  late UserModel _currentUser;
  late UserModel _guestUser;
  final _currentUserCache = Hive.box(TextConstant.currentUserPath);

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _currentUser = _currentUserCache.get('user');
    _guestUser = _currentUserCache.get('guest_user');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainPageBloc(),
      child: BlocProvider(
        create: (context) => ChatBloc(),
        child: BlocConsumer<ChatBloc, ChatState>(
          listener: (context, state) {
            if (state.status == ChatStatus.loading) {
              const Center(child: CircularProgressIndicator());
            }
          },
          builder: (context, state) {
            if (state.listMessage != []) {
              _listMessage = state.listMessage;
              return Scaffold(
                appBar: AppBarChatPage(
                  currentUser: _currentUser,
                  guestUser: _guestUser,
                ),
                body: Stack(
                  children: [
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
                                  isCurrentUser: (_currentUser.id ==
                                      _listMessage![index].fromId));
                            },
                          ),
                        ),
                        (state.status == ChatStatus.imageLoading)
                            ? Lottie.asset(
                                Assets.lottie.imageLoading.path,
                                width: 55,
                                height: 55,
                              )
                            : Container(),
                        const SizedBox(height: 10),
                        MessageInput(
                          currentUser: _currentUser,
                          guestUser: _guestUser,
                          listMessage: _listMessage!,
                          messageController: _messageController,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Say hello ✌️'));
            }
          },
        ),
      ),
    );
  }
}
