import 'dart:io';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
// ignore: unused_import
import 'package:lottie/lottie.dart';
import 'package:chatapp/src/widgets/custom_text_form_field.dart';
import 'package:chatapp/src/features/chat/bloc/chat_bloc.dart';
import 'package:chatapp/src/utils/dialog_util.dart';

import 'package:chatapp/src/models/message_model.dart';

class BuildMessageInput extends StatefulWidget {
  final TextEditingController messageController;
  final UserModel currentUser;
  final UserModel guestUser;
  final List<MessageModel> listMessage;

  const BuildMessageInput(
      {super.key,
      required this.messageController,
      required this.currentUser,
      required this.guestUser,
      required this.listMessage});

  @override
  State<BuildMessageInput> createState() => _BuildMessageInputState();
}

class _BuildMessageInputState extends State<BuildMessageInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            _getImageFromDeviceNoti(context);
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Center(
                // child: Lottie.asset(ImageHelper.gallery,
                //     fit: BoxFit.cover, width: 55, height: 55),
                ),
          ),
        ),
        Expanded(
          child: CustomTextFormField(
              controller: widget.messageController,
              keyboardType: TextInputType.multiline,
              hintText: ''),
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
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text('data'),
            // Lottie.asset(ImageHelper.send,
            //     fit: BoxFit.cover, width: 55, height: 55),
          ),
        ),
      ],
    );
  }

  void _getImageFromDeviceNoti(BuildContext context) {
    DialogUtil.showBothOkAndCancel(
        body: 'Select a photo in',
        cancelIcon: Icons.camera,
        cancelText: 'Camera',
        context: context,
        okIcon: Icons.image,
        okText: 'Gallery',
        okOnPress: () {
          _getImageFromGallery();
        },
        cancelOnPress: () {
          _getImageFromCamera();
        });
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

  void _sendFirstMessage(
      {required UserModel guestUser,
      required UserModel currentUser,
      required String msg,
      required Type type}) async {
    context
        .read<ChatBloc>()
        .add(ChatSendFirstMessage(guestUser, currentUser, msg, type));
  }

  void _sendMessage(
      {required UserModel guestUser,
      required UserModel currentUser,
      required String msg,
      required Type type}) async {
    context
        .read<ChatBloc>()
        .add(ChatSendMessage(guestUser, currentUser, msg, type));
  }
}
