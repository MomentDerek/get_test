// 登录返回
import 'dart:convert';

class UserLoginResponseEntity {
  String? accessToken;
  String? refreshToken;

  UserLoginResponseEntity({
    this.accessToken,
    this.refreshToken,
  });

  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseEntity(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "refresh_token": refreshToken,
  };
}


class UserInfoEntity {
  UserInfoEntity({
    this.workId,
    this.username,
    this.nickname,
    this.email,
    this.phone,
  });

  String? workId;
  String? username;
  String? nickname;
  String? email;
  String? phone;

  @override
  String toString() {
    return toRawJson();
  }

  factory UserInfoEntity.fromRawJson(String str) => UserInfoEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserInfoEntity.fromJson(Map<String, dynamic> json) => UserInfoEntity(
    workId: json["workId"],
    username: json["username"],
    nickname: json["nickname"],
    email: json["email"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "workId": workId,
    "username": username,
    "nickname": nickname,
    "email": email,
    "phone": phone,
  };
}

