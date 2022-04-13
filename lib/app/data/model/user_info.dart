
import 'dart:convert';

class UserInfoModel {
    UserInfoModel({
        required this.workId,
        required this.username,
        required this.nickname,
        required this.email,
        required this.phone,
    });

    String workId;
    String username;
    String nickname;
    String email;
    String phone;

    @override
    String toString() {
      return toRawJson();
    }

    factory UserInfoModel.fromRawJson(String str) => UserInfoModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
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
