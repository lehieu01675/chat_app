import 'dart:developer';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/features/dash_board/bloc/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:chatapp/src/widgets/basic_app_bar.dart';
import 'package:chatapp/src/widgets/build_loading_circle.dart';
import 'package:chatapp/src/features/contact/view/contact_screen.dart';
import 'package:chatapp/src/features/main_screen/view/main_screen.dart';
import 'package:chatapp/src/features/profile/view/profile_screen.dart';
import 'package:chatapp/src/helper/color_helper.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  UserModel currentUser = UserModel(
    listChatID: [],
      image: '',
      introduce: '',
      name: '',
      createdAt: '',
      lastActive: '',
      isOnline: false,
      id: '',
      checkId: '',
      email: '',
      gender: '',
      pushToken: '',
      phoneNumber: '');

  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();

    /// get information of current user
    _getCurrentUser();

    /// update status of current user is online
    _updateUserStatus(status: true);

    /// depend on lifecycle of app to set status of current user
    _setStatusOfCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      bottomNavigationBar: _bottomNavigationBar(),
      body: BlocListener<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DashboardCreateNewDataUserFailed) {
            /// if don't get the information of current user => push to signIn
            //  TransitionHelper.nextScreenReplace(context, SignInPage());
          }
        },
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardGetCurrentUserSuccess) {
              /// get the information of current user
              currentUser = state.currentUser;

              /// tab include 3 main Screen
              final tab = [
                ContactPage(currentUser: currentUser),
                MainScreen(currentUser: currentUser),
                ProfilePage(currentUser: currentUser)
              ];

                return tab[_currentIndex];

            }
            return const Center(
                child: BuildLoadingCircle(width: 100, height: 100));
          },
        ),
      ),
    );
  }

  /// get current user
  void _getCurrentUser() {
    BlocProvider.of<DashboardBloc>(context).add(DashboardGetCurrentUser());
  }

  /// update status of current user is on/off
  void _updateUserStatus({required bool status}) {
    BlocProvider.of<DashboardBloc>(context)
        .add(DashboardUpdateUserStatus(status: status));
  }

  void _setStatusOfCurrentUser() {
    SystemChannels.lifecycle.setMessageHandler((message) {
      log("message: ${message.toString()}");
      if (currentUser.id != '') {
        if (message.toString().contains('resumed')) {
          _updateUserStatus(status: true);
        }
        if (message.toString().contains('paused') ||
            message.toString().contains('inactive')) {
          _updateUserStatus(status: false);
        }
      }
      return Future.value(message);
    });
  }

  /// bottom navigation bar
  Widget _bottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: ColorHelper.lightMain,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(0.3),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 5,
            activeColor: Colors.black,
            iconSize: 30,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            tabs: [
              GButton(
                  icon: LineIcons.peopleCarry,
                  text: 'Contacts',
                  iconColor: ColorHelper.lightIconBottomNavigationBar),
              GButton(
                  icon: LineIcons.facebookMessenger,
                  text: 'Chat',
                  iconColor: ColorHelper.lightIconBottomNavigationBar),
              GButton(
                  icon: LineIcons.userCircle,
                  text: 'Profile',
                  iconColor: ColorHelper.lightIconBottomNavigationBar),
            ],
            selectedIndex: _currentIndex,
            onTabChange: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
