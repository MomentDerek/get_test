import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_test/common/api/api.dart';
import 'package:get_test/common/api/login.dart';
import 'package:get_test/common/constant/constant.dart';
import 'package:get_test/common/entity/entity.dart';
import 'package:get_test/common/service/services.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  // 是否登录
  final _isLogin = false.obs;

  // 令牌 token
  String accessToken = '';
  String refreshToken = '';

  // 用户 profile
  final _profile = UserInfoEntity().obs;

  bool get isLogin => _isLogin.value;

  UserInfoEntity get profile => _profile.value;

  bool get hasToken => accessToken.isNotEmpty && refreshToken.isNotEmpty;


  Future<UserStore> init() async {
    accessToken = StorageService.to.getString(ACCESS_TOKEN_KEY);
    refreshToken = StorageService.to.getString(REFRESH_TOKEN_KEY);
    await checkAccessToken().then((value) {
      if (value) {
        _isLogin.value = true;
        var profileOffline =
            StorageService.to.getString(STORAGE_USER_PROFILE_KEY);
        if (profileOffline.isNotEmpty) {
          _profile(UserInfoEntity.fromJson(jsonDecode(profileOffline)));
        }
      } else {
        accessToken = "";
        refreshToken = "";
      }
    });
    return this;
  }

  Future<bool> checkAccessToken() async {
    return await Get.find<LoginProvider>().checkToken(accessToken);
  }

  // 保存 token
  Future<void> setAccessToken(String value) async {
    await StorageService.to.setString(ACCESS_TOKEN_KEY, value);
    accessToken = value;
  }

  // 保存 token
  Future<void> setRefreshToken(String value) async {
    await StorageService.to.setString(REFRESH_TOKEN_KEY, value);
    refreshToken = value;
  }

  // 获取 profile
  Future<void> getProfile() async {
    if (!hasToken) {
      onLogout();
      return;
    }
    var userProvider = Get.find<UserProvider>();
    var result = await userProvider.profile();
    if (result.code != 200) {
      onLogout();
      return;
    }
    _profile(UserInfoEntity.fromJson(result.data));
    _isLogin.value = true;
    StorageService.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(result));
  }

  // 保存 profile
  Future<void> saveProfile(UserInfoEntity profile) async {
    _isLogin.value = true;
    StorageService.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profile));
  }

  // 注销
  Future<void> onLogout() async {
    await StorageService.to.remove(ACCESS_TOKEN_KEY);
    await StorageService.to.remove(REFRESH_TOKEN_KEY);
    _isLogin.value = false;
    _profile.value = UserInfoEntity();
    accessToken = '';
    refreshToken = '';
  }
}
