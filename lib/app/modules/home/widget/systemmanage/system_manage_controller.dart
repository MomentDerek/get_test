import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_test/common/api/api.dart';
import 'package:get_test/common/entity/user_password_update.dart';
import 'package:get_test/common/entity/user_register.dart';
import 'package:get_test/common/store/user.dart';

class SystemManageController extends GetxController {
  static SystemManageController get to => Get.find();

  TextEditingController workIdEditController = TextEditingController();
  TextEditingController usernameEditController = TextEditingController();
  TextEditingController passwordEditController = TextEditingController();

  final UserStore _userStore = Get.find<UserStore>();
  final UserProvider _userProvider = Get.find<UserProvider>();

  @override
  void onInit() async {
    super.onInit();
  }

  void updatePassword() async {
    var userRegisterEntity = UserRegisterEntity(
        workIdEditController.text,
        passwordEditController.text,
        usernameEditController.text);
    var responseEntity =
        await _userProvider.register(userRegisterEntity);
    if (responseEntity.code != 200) {
      Get.snackbar('创建用户失败', responseEntity.data.toString(),
          backgroundColor: Colors.black26, duration: Duration(seconds: 1));
    } else {
      Get.snackbar('创建用户成功', workIdEditController.text + '已创建',
          backgroundColor: Colors.black26, duration: Duration(seconds: 1));
    }
  }
}
