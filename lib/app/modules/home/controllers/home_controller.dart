import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_test/app/routes/app_pages.dart';
import 'package:get_test/common/entity/entity.dart';
import 'package:get_test/common/store/user.dart';

class HomeController extends GetxController with StateMixin<UserInfoEntity> {
  final _userStore = Get.find<UserStore>();

  @override
  void onReady() {
    fetchUserInfo();
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
}
