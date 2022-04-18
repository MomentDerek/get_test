class LoginModel {
  String? password;
  String? workId;
  bool isLogin = false;
  String? accessToken;
  String? refreshToken;

  LoginModel({this.workId, this.password, this.accessToken, this.refreshToken});

  LoginModel.fromJson(Map<String, dynamic> json) {
    workId = json['workId'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() => {'workId': workId, 'password': password};
}
