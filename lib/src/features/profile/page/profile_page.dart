import 'package:chatapp/src/constant/text_cons.dart';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/features/profile/bloc/sign_out_bloc.dart';
import 'package:chatapp/src/features/profile/widgets/avatar_profile_page.dart';
import 'package:chatapp/src/features/profile/widgets/background_profile_page.dart';
import 'package:chatapp/src/features/profile/widgets/build_id_user.dart';
import 'package:chatapp/src/features/profile/widgets/edit_icon.dart';
import 'package:chatapp/src/features/profile/widgets/sign_out_icon.dart';
import 'package:chatapp/src/l10n/app_localizations.dart';
import 'package:chatapp/src/theme/font_theme.dart';
import 'package:chatapp/src/utils/dialog_util.dart';
import 'package:chatapp/src/widgets/custom_arrow_back.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _imagePathCurrentUser = '';
  String _showId = '';
  String _idUser = '';
  late UserModel currentUser;

  final _currentUserCache = Hive.box(TextConstant.currentUserPath);

  @override
  void initState() {
    super.initState();
    currentUser = _currentUserCache.get('user');
    _imagePathCurrentUser = currentUser.image;
    _showId = currentUser.checkId;
    _idUser = FirebaseAuth.instance.currentUser?.uid ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignOutBloc(),
      child: BlocConsumer<SignOutBloc, SignOutState>(
        listener: (context, state) {
          if (state is SignOutError) {
            _showStateError(context, state);
          }
        },
        builder: (context, state) {
          if (state is SignOutFailed) {
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Stack(
                  children: [
                    (_idUser != currentUser.id)
                        ? const CustomArrowBackIcon()
                        : const SizedBox(),
                    Padding(
                      padding: EdgeInsets.only(top: 75.w),
                      child: const BackgroundProfilePage(),
                    ),
                    Column(
                      children: [
                        _showAvatar(),
                        IdUserWidget(showId: _showId),
                        Text(
                          currentUser.name,
                          textAlign: TextAlign.center,
                          style: FontTheme.mineShaft30W600Poppins,
                        ),
                        Text(
                          currentUser.introduce,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          style: FontTheme.mineShaft15W500RobotoMono,
                        ),
                      ],
                    ),
                    if (_idUser == currentUser.id) ...[
                      _buildIcon(),
                    ]
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildIcon() {
    return Positioned(
      top: 75.w,
      right: 10.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const EditIconWidget(),
          SizedBox(height: 10.h),
          const SignOutIconWidget(),
        ],
      ),
    );
  }

  void _showStateError(BuildContext context, SignOutError state) {
    DialogUtil.showException(
      context: context,
      onPressedOK: () {},
      title: AppLocalizations.of(context)!.signOutFailed,
      message: state.message,
    );
  }

  Widget _showAvatar() {
    return AvatarProfilePage(avatarPath: _imagePathCurrentUser);
  }
}
