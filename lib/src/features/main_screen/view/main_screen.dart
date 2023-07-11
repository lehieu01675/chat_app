import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/features/main_screen/bloc/main_screen_bloc.dart';
import 'package:chatapp/src/features/main_screen/build_widgets/build_online_dot.dart';
import 'package:chatapp/src/features/main_screen/repositories/main_screen_repo.dart';
import 'package:chatapp/src/helper/color_helper.dart';
import 'package:chatapp/src/widgets/build_loading_circle.dart';
import 'package:chatapp/src/widgets/custom_chat_card.dart';
import 'package:chatapp/src/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MainScreen extends StatefulWidget {
  final UserModel currentUser;

  const MainScreen({super.key, required this.currentUser});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<UserModel> _listChatUser = [];
  Offset _offset = const Offset(300, 600);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) =>
          MainScreenBloc(mainScreenRepository: MainScreenRepository()),
      child: BlocBuilder<MainScreenBloc, MainScreenState>(
        builder: (context, state) {
          // listen the change of firebase to load chat user
          if (state is MainScreenGetListChatUserSuccess) {
            _listChatUser = state.listChatUser;
            return (_listChatUser.isEmpty)
                ? _floatingButton(context)
                : Stack(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: AnimationLimiter(
                        child: ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            itemCount: _listChatUser.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredList(
                                  position: index,
                                  delay: const Duration(milliseconds: 100),
                                  child: SlideAnimation(
                                      duration:
                                          const Duration(milliseconds: 2500),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      child: FadeInAnimation(
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          duration: const Duration(
                                              milliseconds: 2500),
                                          child: CustomChatCard(
                                            onPressed: (context) {
                                              context
                                                  .read<MainScreenBloc>()
                                                  .add(MainScreenDeleteChatUser(
                                                      id: _listChatUser[index]
                                                          .id));
                                            },
                                            // online icon
                                            trailing:
                                                _listChatUser[index].isOnline
                                                    ? const BuildOnLineDot()
                                                    : const Text(''),
                                            subTitle: Text(
                                              _listChatUser[index].checkId,
                                              maxLines: 1,
                                            ),
                                            isChatPage: true,
                                            guestUser: _listChatUser[index],
                                            currentUser: widget.currentUser,
                                          ))));
                            }),
                      ),
                    ),
                    _floatingButton(context)
                  ]);
          }
          return const Center(
              child: BuildLoadingCircle(
            height: 100,
            width: 100,
          ));
        },
      ),
    ));
  }

  ///
  Widget _floatingButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Stack(
          children: [
            Positioned(
              left: _offset.dx,
              top: _offset.dy,
              child: GestureDetector(
                onPanUpdate: (details) => setState(() {
                  log(_offset.dx.toString());
                  log('-');
                  log(_offset.dy.toString());
                  _offset += (details.delta * 1.2);
                }),
                child: FloatingActionButton(
                    backgroundColor: ColorHelper.lightMain,
                    onPressed: () {
                      _addChatUserDialog(context);
                    },
                    child: const Icon(Icons.add_comment_rounded, size: 30)),
              ),
            ),
          ],
        ));
  }

  /// add new chat user
  void _addChatUserDialog(BuildContext context) {
    String input = '';

    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.TOPSLIDE,
      headerAnimationLoop: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomTextFormField(
          maxLines: 1,
          onChanged: (value) => input = value,
          controller: null,
          hintText: 'Enter ID',
          keyboardType: TextInputType.number,
          prefixIcon: const Icon(Icons.code_sharp, color: Colors.blue),
        ),
      ),
      btnOkIcon: Icons.check,
      btnOkColor: Colors.blue,
      btnOkOnPress: () async {
        if (input.isNotEmpty) {
          BlocProvider.of<MainScreenBloc>(context)
              .add(MainScreenAddChatUser(checkId: input));
        }
      },
    ).show();
  }
}
