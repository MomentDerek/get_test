import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_test/app/data/model/response.dart';
import 'package:get_test/common/api/base.dart';
import 'package:get_test/common/entity/user_info_update.dart';
import 'package:get_test/common/entity/user_password_update.dart';
import 'package:get_test/common/entity/user_register.dart';

class ChatProvider extends BaseProvider {
  static ChatProvider get to => Get.find();


  Future<ResponseEntity> listChats() => get("/api/chat/list")
      .then((value) => ResponseEntity.fromJson(value.body));

  Future<ResponseEntity> getMessages(String friendWorkId) => get("/api/chat/"+friendWorkId)
      .then((value) => ResponseEntity.fromJson(value.body));

  Future<ResponseEntity> sendMessage(String friendWorkId,String message) => 
      post("/api/chat/send/"+friendWorkId,message)
      .then((value) => ResponseEntity.fromJson(value.body));


  @override
  void onInit() {
    super.onInit();
  }
}
