import 'dart:convert';

import 'package:get_test/app/data/model/response.dart';
import 'package:get_test/common/api/base.dart';
import 'package:get_test/common/entity/user_info_update.dart';
import 'package:get_test/common/entity/user_password_update.dart';
import 'package:get_test/common/entity/user_register.dart';

class UserProvider extends BaseProvider {
  Future<ResponseEntity> profile() => get("/api/user/info/")
      .then((value) => ResponseEntity.fromJson(value.body));

  Future<ResponseEntity> teamProfile() => get("/api/system/team")
      .then((value) => ResponseEntity.fromJson(value.body));

  Future<ResponseEntity> updateUserPassword(UserPasswordUpdateEntity entity) =>
      post("/api/system/user/update_password", json.encode(entity.toJson()))
          .then((value) => ResponseEntity.fromJson(value.body));

  Future<ResponseEntity> register(UserRegisterEntity entity) =>
      post("/api/system/user/register", json.encode(entity.toJson()))
          .then((value) => ResponseEntity.fromJson(value.body));

  Future<ResponseEntity> updateUserInfo(UserInfoUpdateEntity entity) =>
      post("/api/system/user/update", json.encode(entity.toJson()))
          .then((value) => ResponseEntity.fromJson(value.body));

  @override
  void onInit() {
    super.onInit();
  }
}
