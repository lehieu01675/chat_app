import 'package:chatapp/src/constant/text_cons.dart';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/features/authentication/phong_number/widgets/list_chat_card.dart';
import 'package:chatapp/src/features/main_screen/bloc/main_page_bloc.dart';
import 'package:chatapp/src/features/main_screen/widgets/floating_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<UserModel> _listChatUser = [];
  late Offset _offset = const Offset(300, 600);
  late UserModel currentUser;

  final _currentUserCache = Hive.box(TextConstant.currentUserPath);

  @override
  void initState() {
    super.initState();
    currentUser = _currentUserCache.get('user');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainPageBloc(),
      child: BlocBuilder<MainPageBloc, MainScreenState>(
        builder: (context, state) {
          if (state is MainScreenGetListChatUserSuccess) {
            _listChatUser = state.listChatUser;
            return Scaffold(
              body: (_listChatUser.isEmpty)
                  ? _buildFloatingButton()
                  : Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: ListChatCardWidget(
                            listChatUser: _listChatUser,
                            currentUser: currentUser,
                          ),
                        ),
                        _buildFloatingButton(),
                      ],
                    ),
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
