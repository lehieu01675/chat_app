import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/data/repositories/chat_user_repository.dart';
import 'package:chatapp/src/data/repositories/list_chat_user_repo.dart';
import 'package:chatapp/src/features/authentication/phong_number/widgets/list_chat_card.dart';
import 'package:chatapp/src/features/main_screen/bloc/main_page_bloc.dart';
import 'package:chatapp/src/features/main_screen/widgets/floating_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatefulWidget {
  final UserModel currentUser;

  const MainPage({super.key, required this.currentUser});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<UserModel> _listChatUser = [];
  late Offset _offset = const Offset(300, 600);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainPageBloc(
        listChatUserRepository: ListChatUserRepository(),
        chatUserRepository: ChatUserRepository(),
      ),
      child: BlocBuilder<MainPageBloc, MainScreenState>(
        builder: (context, state) {
          if (state is MainScreenGetListChatUserSuccess) {
            _listChatUser = state.listChatUser;
            return Scaffold(
              body: (_listChatUser.isEmpty)
                  ? _buildFloatingButton()
                  : Stack(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: ListChatCardWidget(
                          listChatUser: _listChatUser,
                          currentUser: widget.currentUser,
                        ),
                      ),
                      _buildFloatingButton(),
                    ]),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildFloatingButton() {
    return FloatingButton(
      offset: _offset,
      onPanUpdate: (details) => setState(() {
        _offset += (details.delta * 1.2);
      }),
    );
  }
}
