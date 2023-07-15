import 'dart:io';
import 'package:chatapp/src/constant/text_cons.dart';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/data/repositories/file_picker_repo.dart';
import 'package:chatapp/src/features/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:chatapp/src/features/edit_profile/widgets/avatar_edit_profile.dart';
import 'package:chatapp/src/features/edit_profile/widgets/form_edit_profile.dart';
import 'package:chatapp/src/features/profile/widgets/background_profile_page.dart';
import 'package:chatapp/src/l10n/app_localizations.dart';
import 'package:chatapp/src/widgets/custom_arrow_back.dart';
import 'package:chatapp/src/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chatapp/src/widgets/custom_button.dart';
import 'package:chatapp/src/utils/dialog_util.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _keyForm = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _aboutController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String? _currentName;
  String? _currentAbout;
  String? _currentEmail;
  String? _currentPhoneNumber;

  String? _nameInput;
  String? _aboutInput;
  String? _emailInput;
  String? _phoneNumberInput;
  String? _image;
  late UserModel currentUser;

  final _currentUserCache = Hive.box(TextConstant.currentUserPath);

  @override
  void initState() {
    super.initState();
    currentUser = _currentUserCache.get('user');
    _currentName = currentUser.name;
    _currentAbout = currentUser.introduce;
    _currentEmail = currentUser.email;
    _currentPhoneNumber = currentUser.phoneNumber;
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
    return BlocConsumer<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccess) {
          _showSuccessDialog(context);
        }
        if (state is EditProfileError) {
          _showFailedDialog(context, state);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50.h),
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 75.w),
                        child: const BackgroundProfilePage(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            SizedBox(height: 165.w),
                            FormEditProfile(
                              nameController: _nameController,
                              aboutController: _aboutController,
                              emailController: _emailController,
                              phoneNumberController: _phoneNumberController,
                              currentName: _currentName ?? "",
                              currentAbout: _currentAbout ?? "",
                              currentEmail: _currentEmail ?? "",
                              currentPhoneNumber: _currentPhoneNumber ?? "",
                              keyForm: _keyForm,
                            ),
                            SizedBox(height: 20.h),
                            CustomButton.curiousBlue(
                              onPress: () {
                                _nameInput = _nameController.text.trim();
                                _aboutInput = _aboutController.text.trim();
                                _emailInput = _emailController.text.trim();
                                _phoneNumberInput =
                                    _phoneNumberController.text.trim();

                                _updateProfile(
                                    about: _aboutInput == ''
                                        ? _currentAbout!
                                        : _aboutInput!,
                                    name: _nameInput == ''
                                        ? _currentName!
                                        : _nameInput!,
                                    email: _emailInput == ''
                                        ? _currentEmail!
                                        : _emailInput!,
                                    phoneNumber: _phoneNumberInput == ''
                                        ? _currentPhoneNumber!
                                        : _phoneNumberInput!);
                              },
                              label: AppLocalizations.of(context)!.update,
                            ),
                          ],
                        ),
                      ),
                      AvatarEditProfile(
                        pickImage: () => _pickImage(),
                        image: _image == null
                            ? CustomAvatar(
                                imageUrl: currentUser.image,
                              )
                            : Image.file(
                                File(_image!),
                                fit: BoxFit.cover,
                              ),
                      ),
                      const CustomArrowBackIcon(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _updateProfile({
    required String name,
    required String about,
    required String email,
    required String phoneNumber,
  }) {
    context.read<EditProfileBloc>().add(UpdateProfile(
          introduce: about,
          name: name,
          email: email,
          phoneNumber: phoneNumber,
        ));
  }

  void _showFailedDialog(BuildContext context, EditProfileError state) {
    DialogUtil.showException(
      onPressedOK: () {},
      context: context,
      title: AppLocalizations.of(context)!.updateFailed,
      message: state.error,
    );
  }

  void _showSuccessDialog(BuildContext context) {
    DialogUtil.showSuccess(
      context: context,
      title: AppLocalizations.of(context)!.updateSuccess,
      message: '',
      onPressedOK: () {},
    );
  }

  void _pickImage() async {
    final FilePickerRepository filePicker = GetIt.I.get<FilePickerRepository>();
    final XFile? xImage = await filePicker.pickOneImage();

    if (xImage != null) {
      setState(() {
        _image = xImage.path;
      });
    }
    _updateAvatar(File(_image!));
  }

  void _updateAvatar(File file) {
    context.read<EditProfileBloc>().add((UpdateAvatar(file: file)));
  }
}
