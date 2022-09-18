import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_test/app/routes/app_pages.dart';
import 'package:get_test/common/api/login.dart';
import 'package:get_test/common/store/user.dart';

class LoginController extends GetxController {
  final _loginProvider = Get.find<LoginProvider>();
  final _userStore = Get.find<UserStore>();


  FocusNode workIdFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  TextEditingController workIdEditController = TextEditingController();
  TextEditingController passwordEditController = TextEditingController();

  var passwordIsObscure = true.obs;

  var workId = "".obs;
  var password = "".obs;


  login() {
    _loginProvider.login(workId.value, password.value).then((response) async{
      if (response.isOk) {
        await _userStore.setAccessToken(response.body["access_token"]);
        await _userStore.setRefreshToken(response.body["refresh_token"]);
        await _userStore.getProfile();
        workIdEditController.clear();
        passwordEditController.clear();
        print(_userStore.role);
        //后面就应该跳转到首页
        Get.offNamed(Routes.HOME);
        print("登录成功");
      } else {
        printError(info: "登录失败");
        _userStore.onLogout();
      }
    });
  }

  static LoginController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    debounce(password, (_)=>print("密码更改：$_"),time: Duration(seconds: 1));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
  }


}
