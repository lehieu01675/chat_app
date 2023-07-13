import 'dart:developer';
import 'package:chatapp/src/constant/text_cons.dart';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/features/contact/view/contact_page.dart';
import 'package:chatapp/src/features/dash_board/bloc/dashboard_bloc.dart';
import 'package:chatapp/src/features/main_screen/page/main_page.dart';
import 'package:chatapp/src/router/route_paths.dart';
import 'package:chatapp/src/theme/color_theme.dart';
import 'package:chatapp/src/widgets/background_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:chatapp/src/widgets/basic_app_bar.dart';
import 'package:chatapp/src/features/profile/view/profile_screen.dart';
import 'package:chatapp/src/helper/color_helper.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DashboardCreateNewDataUserFailed) {
            context.go(RoutePaths.signIn);
          }
        },
        builder: (context, state) {
          if (state is DashboardGetCurrentUserSuccess) {
            currentUser = state.currentUser;
            final tab = [
              ContactPage(currentUser: currentUser),
              MainPage(currentUser: currentUser),
              ProfilePage(currentUser: currentUser)
            ];
            return tab[_currentIndex];
          }
          return const BackgroundImageWidget();
        },
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

  Widget _bottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: ColorTheme.curiousBlue,
        boxShadow: [
          BoxShadow(
            blurRadius: 20.r,
            color: Colors.black.withOpacity(0.3),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 5,
            activeColor: Colors.black,
            iconSize: 30.sp,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            tabs: [
              GButton(
                  icon: LineIcons.peopleCarry,
                  text: TextConstant.contact,
                  iconColor: ColorHelper.lightIconBottomNavigationBar),
              GButton(
                  icon: LineIcons.facebookMessenger,
                  text: TextConstant.chat,
                  iconColor: ColorHelper.lightIconBottomNavigationBar),
              GButton(
                  icon: LineIcons.userCircle,
                  text: TextConstant.profile,
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
