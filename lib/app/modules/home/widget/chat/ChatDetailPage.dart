import 'dart:convert';
import 'dart:developer';
import 'dart:math' show Random;
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:get_test/app/modules/home/home_controller.dart';
import 'package:get_test/common/store/user.dart';

// For the testing purposes, you should probably use https://pub.dev/packages/uuid
String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class ChatDetailPage extends StatelessWidget {
  ChatDetailPage(this.controller, String friendWorkId, {Key? key})
      : super(key: key) {
    _friend = types.User(id: friendWorkId);
    _user = types.User(id: UserStore.to.profile.workId!);
    controller.fetchChatMessageList(_friend);
  }

  HomeController controller;

  late final types.User _user;
  late final types.User _friend;

  void _addMessage(types.TextMessage message) {
    controller.sendChatMessage(_friend.id, message.text).then((value) {
      if (value) controller.messageTemp.insert(0, message);
      controller.update();
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<HomeController>(builder: (_) {
            return Chat(
              messages: _.messageTemp,
              onSendPressed: _handleSendPressed,
              user: _user,
            );
          }),
          LoginCloseButton()
        ],
      ),
    );
  }
}

class LoginCloseButton extends StatelessWidget {
  const LoginCloseButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: CloseButton(onPressed: () {
        HomeController.to.fetchChatList();
        Navigator.of(context).pop();
      }),
      left: 20,
      top: 20,
    );
  }
}
