import 'dart:convert';
import 'dart:developer';
import 'dart:math' show Random;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_test/app/modules/home/widget/chat/ChatDetailPage.dart';
import 'package:get_test/app/routes/app_pages.dart';
import 'package:get_test/common/api/chat.dart';
import 'package:get_test/common/entity/chat_distribute_message.dart';
import 'package:get_test/common/entity/chat_info.dart';
import 'package:get_test/common/entity/chat_message.dart';
import 'package:get_test/common/entity/entity.dart';
import 'package:get_test/common/store/user.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:web_socket_channel/io.dart';

class HomeController extends GetxController with StateMixin<UserInfoEntity> {
  static HomeController get to => Get.find();

  final _userStore = Get.find<UserStore>();
  var showSideMenu = true.obs;
  var pageViewController = PageController(initialPage: 0);
  var chatList = <ChatInfoEntity>[].obs;
  var messageTemp = <types.Message>[];
  var messageWorkIdTemp = '';

  late MaterialPageRoute chatNavigator;
  late IOWebSocketChannel channel;

  @override
  void onReady() async {
    await fetchUserInfo();
    await fetchChatList();
    setWebSocket();
  }

  void setWebSocket() {
    Map<String, dynamic> headers = {"workId": _userStore.profile.workId};
    channel = IOWebSocketChannel.connect('ws://localhost:8201/local/ws',
        // 可以设置请求头
        headers: headers);
    channel.stream.listen((message) {
      ChatDistributeMessageEntity messageEntity = ChatDistributeMessageEntity
          .fromJson(jsonDecode(message));
      if (messageEntity.fromWorkId == messageWorkIdTemp) {
        messageTemp.insert(0, types.TextMessage(
          author: types.User(id: messageWorkIdTemp),
          createdAt: DateTime
              .now()
              .millisecondsSinceEpoch,
          id: randomString(),
          text: messageEntity.message,
        ));
        update();
      }
    });
  }

  void switchPage(int page) {
    pageViewController.jumpToPage(page);
  }

  Future<void> fetchUserInfo() async {
    log("开始拉取用户信息");
    if (_userStore.isLogin) {
      await _userStore.getProfile();
      change(_userStore.profile, status: RxStatus.success());
    } else {
      change(UserInfoEntity(), status: RxStatus.error("获取失败，请重新登录"));
      Get.offNamed(Routes.LOGIN);
    }
  }

  Future<void> fetchChatList() async {
    chatList.clear();
    var responseEntity = await ChatProvider.to.listChats();
    if (responseEntity.code != 200) {
      Get.snackbar('获取聊天列表失败', responseEntity.data.toString(),
          backgroundColor: Colors.black26, duration: Duration(seconds: 1));
      return;
    }
    List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>
        .from(responseEntity.data);
    for(var chatInfo in dataList) {
      chatList.add(ChatInfoEntity.fromJson(chatInfo));
    }
  }

  Future<void> fetchChatMessageList(types.User friend) async {
    messageTemp.clear();
    messageWorkIdTemp = friend.id;
    var responseEntity = await ChatProvider.to.getMessages(friend.id);
    if (responseEntity.code != 200) {
      Get.snackbar('获取聊天记录失败', responseEntity.data.toString(),
          backgroundColor: Colors.black26, duration: Duration(seconds: 1));
      return;
    }
    List<Map<String, dynamic>> dataList =
    List<Map<String, dynamic>>.from(responseEntity.data);
    for (var messageData in dataList) {
      ChatMessageEntity messageEntity = ChatMessageEntity.fromJson(messageData);
      messageTemp.insert(0, types.TextMessage(
        author: types.User(id: messageEntity.sender),
        createdAt: DateTime
            .parse(messageEntity.time)
            .millisecondsSinceEpoch,
        id: messageEntity.id,
        text: messageEntity.message,
      ));
    }
    update();
  }

  Future<bool> sendChatMessage(String friendWorkId, String message) async {
    var responseEntity = await ChatProvider.to.sendMessage(
        friendWorkId, message);
    if (responseEntity.code != 200) {
      Get.snackbar('信息发送失败', responseEntity.data.toString(),
          backgroundColor: Colors.black26, duration: Duration(seconds: 1));
      return false;
    }
    return true;
  }

  void jumpToChat(String friendWorkId){
    if(friendWorkId==_userStore.profile.workId) return;
    // for(var chatInfo in chatList) {
    //   if(chatInfo.workId == friendWorkId) {
    //     Navigator.of(chatBuildContext).popUntil(ModalRoute.withName("/"));
    //     Navigator.of(chatBuildContext).push(MaterialPageRoute(builder: (context) {
    //       return ChatDetailPage(this,friendWorkId);
    //     }));
    //     return;
    //   }
    // }
    while(chatNavigator.navigator!.canPop()) {
      chatNavigator.navigator!.pop();
    }
    chatNavigator.navigator!.push(MaterialPageRoute(builder: (context) {
      return ChatDetailPage(this,friendWorkId);
    }));
  }

  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
