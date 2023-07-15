import 'dart:io';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/l10n/app_localizations.dart';
import 'package:chatapp/src/theme/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chatapp/src/widgets/custom_text_form_field.dart';
import 'package:chatapp/src/features/chat/bloc/chat_bloc.dart';
import 'package:chatapp/src/utils/dialog_util.dart';

import 'package:chatapp/src/data/models/message_model.dart';
import 'package:lottie/lottie.dart';

class MessageInput extends StatefulWidget {
  final TextEditingController messageController;
  final UserModel currentUser;
  final UserModel guestUser;
  final List<MessageModel> listMessage;

  const MessageInput({
    super.key,
    required this.messageController,
    required this.currentUser,
    required this.guestUser,
    required this.listMessage,
  });

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            _getImageFromDeviceDialog(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Lottie.asset(
              Assets.lottie.gallery.path,
              fit: BoxFit.cover,
              width: 55,
              height: 55,
            ),
          ),
        ),
        Expanded(
          child: CustomTextFormField(
            controller: widget.messageController,
            keyboardType: TextInputType.multiline,
            hintText: '',
          ),
        ),
        InkWell(
          onTap: () {
            if (widget.messageController.text.isNotEmpty) {
              (widget.listMessage.isEmpty)
                  ? _sendFirstMessage(
                      currentUser: widget.currentUser,
                      guestUser: widget.guestUser,
                      msg: widget.messageController.text.trim(),
                      type: Type.text)
                  : _sendMessage(
                      currentUser: widget.currentUser,
                      guestUser: widget.guestUser,
                      msg: widget.messageController.text.trim(),
                      type: Type.text);
            }
            widget.messageController.text = '';
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Lottie.asset(
              Assets.lottie.send.path,
              fit: BoxFit.cover,
              width: 55,
              height: 55,
            ),
          ),
        ),
      ],
    );
  }

  void _getImageFromDeviceDialog(BuildContext context) {
    DialogUtil.showBothOkAndCancel(
      body: AppLocalizations.of(context)!.selectPhotoFrom,
      cancelIcon: Icons.camera,
      cancelText: 'Camera',
      context: context,
      okIcon: Icons.image,
      okText: AppLocalizations.of(context)!.gallery,
      okOnPress: () => _getImageFromGallery(),
      cancelOnPress: () => _getImageFromCamera(),
    );
  }

  void _getImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    _sendImageMessage(
        guestUser: widget.guestUser,
        currentUser: widget.currentUser,
        file: File(image!.path));
  }

  void _getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage(imageQuality: 100);
    for (var i in images) {
      _sendImageMessage(
          currentUser: widget.currentUser,
          guestUser: widget.guestUser,
          file: File(i.path));
    }
  }

  void _sendImageMessage(
      {required UserModel guestUser,
      required UserModel currentUser,
      required File file}) async {
    context.read<ChatBloc>().add(ChatSendImageMessage(
        currentUser: currentUser, guestUser: guestUser, file: file));
  }

  void _sendFirstMessage({
    required UserModel guestUser,
    required UserModel currentUser,
    required String msg,
    required Type type,
  }) async {
    context
        .read<ChatBloc>()
        .add(ChatSendFirstMessage(guestUser, currentUser, msg, type));
  }

  void _sendMessage({
    required UserModel guestUser,
    required UserModel currentUser,
    required String msg,
    required Type type,
  }) async {
    context
        .read<ChatBloc>()
        .add(ChatSendMessage(guestUser, currentUser, msg, type));
  }
}
