
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/features/authentication/sign_in/page/sign_in_page.dart';
import 'package:chatapp/src/features/profile/bloc/sign_out_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatapp/src/features/dash_board/bloc/dashboard_bloc.dart';
import 'package:chatapp/src/features/edit_profile/view/edit_profile_screen.dart';
import 'package:chatapp/src/features/profile/build_widgets/build_id_user.dart';
import 'package:chatapp/src/helper/size_helper.dart';
import 'package:chatapp/src/helper/text_style_helper.dart';
import 'package:chatapp/src/helper/transition_screen_helper.dart';
import 'package:chatapp/src/lay_out/responsive_layout.dart';
import 'package:chatapp/src/features/profile/repositories/profile_repo.dart';

class ProfilePage extends StatefulWidget {
  final UserModel currentUser;
  const ProfilePage({super.key, required this.currentUser});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _imagePathCurrentUser = '';
  String _showId = '';
  String _idUser = '';
  @override
  void initState() {
    super.initState();
    _imagePathCurrentUser = widget.currentUser.image;
    _showId = widget.currentUser.checkId;
    _idUser = FirebaseAuth.instance.currentUser?.uid ?? '';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocProvider(
      create: (context) => SignOutBloc(signOutRepository: SignOutRepository()),
      child: BlocListener<SignOutBloc, SignOutState>(
          listener: (context, state) {
        if (state is SignedOut) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) =>  const SignInPage()),
            (route) => false,
          );
        }
        if (state is SignOutError) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) =>  const SignInPage()),
            (route) => false,
          );
        }
      }, child:
              BlocBuilder<SignOutBloc, SignOutState>(builder: (context, state) {
        if (state is UnSignedOut) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                children: [
                  Row(children: [
                    (_idUser != widget.currentUser.id)
                        ? IconButton(
                            onPressed: () {
                              // TransitionHelper.nextScreen(
                              //     context, const DashBoard());
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios, size: 30))
                        : Container()
                  ]),
                  Column(children: [
                    context.sizedBox(
                        height:
                            context.sizeWidth(150) - SizeHelper.heightOfAppBar),
                    Container(
                      height: context.sizeHeight(500),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 5,
                            blurRadius: 15,
                            offset: const Offset(
                                0, 4), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                      ),
                    ),
                  ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _showAvatar(size),
                        context.sizedBox(
                            height: context.sizeHeight(
                                SizeHelper.textFormFileWithTextFormFiled * 2)),
                        // id of user
                        BuildIdUser(
                          showId: _showId,
                        ),
                        context.sizedBox(
                            height:
                                SizeHelper.textFormFileWithTextFormFiled / 2),
                        // name of user
                        Text(widget.currentUser.name,
                            textAlign: TextAlign.center,
                            style: TextStyleHelper.nameOfProfile),
                        context.sizedBox(
                            height: SizeHelper.textFormFileWithTextFormFiled),
                        // about of user
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  SizeHelper.horizontalOfTextFormFieldSignIn),
                          child: Text(widget.currentUser.introduce,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              style: TextStyleHelper.textOfTextFormField),
                        ),
                        context.sizedBox(
                            height:
                                SizeHelper.textFormFileWithTextFormFiled * 5),

                        // check the uid - id of profile need to show
                      ]),
                  if (_idUser == widget.currentUser.id) ...{
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            context.sizedBox(
                                height: context.sizeWidth(150) -
                                    SizeHelper.heightOfAppBar),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () =>
                                        TransitionHelper.nextScreen(
                                            context,
                                            EditingProfileScreen(
                                                currentUser:
                                                    widget.currentUser)),
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 30,
                                    )),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () => _signOut(context: context),
                                    icon: const Icon(
                                      Icons.logout_outlined,
                                      size: 30,
                                    )),
                              ],
                            )
                          ],
                        ))
                  }
                ],
              ),
            ),
          );
        }
        return Container();
      })),
    ));
  }

  void _signOut({required BuildContext context}) {
    // when sign out => update status of user is offline
    context
        .read<DashboardBloc>()
        .add(const DashboardUpdateUserStatus(status: false));
    context.read<SignOutBloc>().add(SignOutAccountEvent());
  }

  Widget _showAvatar(Size size) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Center(
        child: Container(
          width: context.sizeWidth(150),
          height: context.sizeWidth(150),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 3,
                blurRadius: 10,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
          // child: ClipRRect(
          //   borderRadius: BorderRadius.circular(size.height * .5),
          //   child: CachedNetworkImage(
          //     fit: BoxFit.cover,
          //     imageUrl: _imagePathCurrentUser,
          //     errorWidget: (context, url, error) => CircleAvatar(
          //         child: Image(image: AssetImage(ImageHelper.cameraIcon),),),
          //   ),
          // ),
        ),
      ),
    );
  }
}
