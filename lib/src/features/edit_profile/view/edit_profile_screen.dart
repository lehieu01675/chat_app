import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/features/dash_board/page/dash_board_page.dart';
import 'package:chatapp/src/features/edit_profile/bloc/editing_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chatapp/src/widgets/custom_button.dart';
import 'package:chatapp/src/widgets/custom_text_form_field.dart';
import 'package:chatapp/src/utils/dialog_util.dart';
import 'package:chatapp/src/helper/size_helper.dart';
import 'package:chatapp/src/helper/transition_screen_helper.dart';
import 'package:chatapp/src/lay_out/responsive_layout.dart';


class EditingProfileScreen extends StatefulWidget {
  final UserModel currentUser;
  final bool? isCheck;
  const EditingProfileScreen(
      {super.key, required this.currentUser, this.isCheck});

  @override
  State<EditingProfileScreen> createState() => _EditingProfileScreenState();
}

class _EditingProfileScreenState extends State<EditingProfileScreen> {
  final _nameController = TextEditingController();
  final _aboutController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String? _nameCurrentUser;
  String? _aboutCurrentUser;
  String? _emailCurrentUser;
  String? _phoneNumberCurrentUser;

  String? _nameInput;
  String? _aboutInput;
  String? _emailInput;
  String? _phoneNumberInput;
  String? _image;

  @override
  void initState() {
    super.initState();
    context.read<EditingProfileBloc>().add(EditingProfileGetCurrentUser());
    _nameCurrentUser = widget.currentUser.name;
    _aboutCurrentUser = widget.currentUser.introduce;
    _emailCurrentUser = widget.currentUser.email;
    _phoneNumberCurrentUser = widget.currentUser.phoneNumber;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _aboutController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocListener<EditingProfileBloc, EditingProfileState>(
            listener: (context, state) {
      if (state is EditingProfileUpdatedProfile) {
        _showSuccessDialog(context);
      }
      if (state is EditingProfileError) {
        _showFailedDialog(context, state);
      }
    }, child: BlocBuilder<EditingProfileBloc, EditingProfileState>(
                builder: (context, state) {
      return SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Stack(children: [
            Column(children: [
              // radius of avatar is 150
              context.sizedBox(height: context.sizeWidth(150)),
              Container(
                height: context.smallDevice()
                    ? context.sizeHeight(580)
                    : context.sizeHeight(480),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 5,
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      context.sizedBox(
                          height: context.sizeWidth(SizeHelper.avatar +
                              SizeHelper.textFormFileWithTextFormFiled)),
                      CustomTextFormField(
                          controller: _nameController,
                          prefixIcon: const Icon(Icons.text_fields_sharp),
                          keyboardType: TextInputType.text,
                          hintText: 'Name: $_nameCurrentUser'),
                      context.sizedBox(
                          height: SizeHelper.textFormFileWithTextFormFiled),
                      CustomTextFormField(
                          controller: _aboutController,
                          prefixIcon:
                              const Icon(Icons.headphones_battery_sharp),
                          keyboardType: TextInputType.text,
                          hintText: 'Introduce: $_aboutCurrentUser'),
                      context.sizedBox(
                          height: SizeHelper.textFormFileWithTextFormFiled),
                      CustomTextFormField(
                          controller: _emailController,
                          prefixIcon: const Icon(Icons.email),
                          keyboardType: TextInputType.text,
                          hintText: 'Email: $_emailCurrentUser'),
                      context.sizedBox(
                          height: SizeHelper.textFormFileWithTextFormFiled),
                      CustomTextFormField(
                          controller: _phoneNumberController,
                          prefixIcon: const Icon(Icons.phone),
                          keyboardType: TextInputType.number,
                          hintText: 'Phone: $_phoneNumberCurrentUser'),
                      context.sizedBox(
                          height: SizeHelper.textFormFieldWithButton),
                      CustomButton.curiousBlue(
                        onPress: () {
                          _nameInput = _nameController.text.trim();
                          _aboutInput = _aboutController.text.trim();
                          _emailInput = _emailController.text.trim();
                          _phoneNumberInput =
                              _phoneNumberController.text.trim();

                          // bug when set the null controller
                          _updateProfile(
                              about: _aboutInput == ''
                                  ? _aboutCurrentUser!
                                  : _aboutInput!,
                              name: _nameInput == ''
                                  ? _nameCurrentUser!
                                  : _nameInput!,
                              email: _emailInput == ''
                                  ? _emailCurrentUser!
                                  : _emailInput!,
                              phoneNumber: _phoneNumberInput == ''
                                  ? _phoneNumberCurrentUser!
                                  : _phoneNumberInput!);
                        },
                        label: 'Update',
                      )
                    ],
                  ),
                ),
              ),
            ]),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // half of avatar 150/2
                  context.sizedBox(
                      height: context.sizeWidth(SizeHelper.avatar)),
                  _image == null
                      ? Center(
                          child: _buildShowAvatar(
                              size,
                              Image.network(
                                widget.currentUser.image,
                                fit: BoxFit.cover,
                              )),
                        )
                      // get the Image FIle to show recently image
                      : Center(
                          child: _buildShowAvatar(
                              size,
                              Image.file(
                                File(_image!),
                                fit: BoxFit.cover,
                              )),
                        ),
                ])
          ]),
        ),
      ));
    })));
  }

  void _updateProfile(
      {required String name,
      required String about,
      required String email,
      required String phoneNumber}) {
    context.read<EditingProfileBloc>().add(EditingProfileUpdateProfile(
        introduce: about, name: name, email: email, phoneNumber: phoneNumber));
  }

  Widget _buildShowAvatar(Size size, Image image) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          shape: const CircleBorder()),
      onPressed: () {
        _selectImage();
      },
      child: Stack(alignment: Alignment.bottomRight, children: [
        Container(
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
          child: ClipRRect(
              borderRadius: BorderRadius.circular(size.height * .5),
              child: image),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 3,
                blurRadius: 15,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          // child: Lottie.asset(ImageHelper.camera,
          //     fit: BoxFit.cover, width: 60, height: 60),
        )
      ]),
    );
  }

  void _showFailedDialog(BuildContext context, EditingProfileError state) {
    DialogUtil.showException(
        onPressedOK: () {},
        context: context,
        title: 'Update failed',
        message: state.error);
  }

  void _showSuccessDialog(BuildContext context) {
    DialogUtil.showDiaLog(
        context: context,
        title: 'Update successful',
        dialogType: DialogType.SUCCES,
        message: '',
        onPressedOK: () {
          TransitionHelper.nextScreenReplace(context, const DashboardPage());
        },
        iconData: Icons.check,
        colorOkButton: Colors.blue);
  }

  void _selectImage() async {
    final picker = ImagePicker();
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (image != null) {
      setState(() {
        _image = image.path;
      });
    }
    _pushAvatar(File(_image!));
  }

  void _pushAvatar(File image) {
    context.read<EditingProfileBloc>().add((EditingProfileUpdateAvatar(image)));
  }
}
