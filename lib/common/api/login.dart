import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_test/app/data/model/response.dart';
import 'package:get_test/common/constant/request.dart';

class LoginProvider extends GetConnect {
  final String _client = OAUTH_CLIENT;
  final String _secret = OAUTH_SECRET;
  final String _baseUrl = REQUEST_BASEURL;

  /// 登录
  Future<Response> login(String workId, String password) => get(
    "/oauth/token",
    query: {
      "grant_type": "password",
      "username": workId,
      "password": password,
    },
    headers: {
      "Authorization":
      'Basic ' + base64Encode(utf8.encode('$_client:$_secret'))
    },
  );


  /// 检查token是否有效
  Future<bool> checkToken(String token) => get(
        "/oauth/check_token",
        query: {"token": token},
        headers: {
          "Authorization":
              'Basic ' + base64Encode(utf8.encode('$_client:$_secret'))
        },
      ).then((value) => value.isOk);

  @override
  void onInit() {
    httpClient.baseUrl = _baseUrl;
  }
}
