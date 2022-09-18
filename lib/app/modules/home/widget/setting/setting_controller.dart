import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_test/app/modules/home/home_controller.dart';
import 'package:get_test/common/api/api.dart';
import 'package:get_test/common/entity/user_info_update.dart';
import 'package:get_test/common/entity/user_password_update.dart';
import 'package:get_test/common/store/user.dart';

class SettingController extends GetxController {
  static SettingController get to => Get.find();

  TextEditingController oldPasswordEditController = TextEditingController();
  TextEditingController newPasswordEditController = TextEditingController();
  TextEditingController nicknameEditController = TextEditingController();
  TextEditingController mailEditController = TextEditingController();
  TextEditingController phoneEditController = TextEditingController();

  final UserStore _userStore = Get.find<UserStore>();
  final UserProvider _userProvider = Get.find<UserProvider>();

  @override
  void onInit() async {
    super.onInit();
  }

  void updatePassword() async {
    var userPasswordUpdateEntity = UserPasswordUpdateEntity(
        _userStore.profile.workId!,
        newPasswordEditController.text,
        oldPasswordEditController.text);
    var responseEntity =
        await _userProvider.updateUserPassword(userPasswordUpdateEntity);
    if (responseEntity.code != 200) {
      Get.snackbar('更改密码失败', responseEntity.data.toString(),
          backgroundColor: Colors.black26, duration: Duration(seconds: 1));
    } else {
      Get.snackbar('更改密码成功', _userStore.profile.workId! + '的信息已更新',
          backgroundColor: Colors.black26, duration: Duration(seconds: 1));
    }
  }

  void updateInfo() async {
    var updateEntity = UserInfoUpdateEntity(
      _userStore.profile.workId!,
      nicknameEditController.text != ""
          ? nicknameEditController.text
          : _userStore.profile.nickname,
      mailEditController.text != ""
          ? mailEditController.text
          : _userStore.profile.email,
      phoneEditController.text != ""
          ? phoneEditController.text
          : _userStore.profile.phone,
    );
    var responseEntity = await _userProvider.updateUserInfo(updateEntity);
    if (responseEntity.code != 200) {
      Get.snackbar('更改资料失败', responseEntity.data.toString(),
          backgroundColor: Colors.black26, duration: Duration(seconds: 1));
    } else {
      Get.snackbar('更改资料成功', _userStore.profile.workId! + '的信息已更新',
          backgroundColor: Colors.black26, duration: Duration(seconds: 1));
      await _userStore.getProfile();
      HomeController.to.change(_userStore.profile,status: RxStatus.success());
    }
  }
}
