import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_test/common/constant/request.dart';
import 'package:get_test/common/store/user.dart';

class BaseProvider extends GetConnect {
  final String _client= OAUTH_CLIENT;
  final String _secret= OAUTH_SECRET;
  final String _baseUrl = REQUEST_BASEURL;

  @override
  void onInit() {
    var userStore = UserStore.to;
    httpClient.baseUrl = _baseUrl;
    httpClient.addRequestModifier((Request request) {
      if(!request.headers.containsKey("Authorization")&&userStore.accessToken!="") {
        request.headers.addAll({"Authorization": "Bearer ${userStore.accessToken}"});
        return request;
      }else{
        return request;
      }
    });

    httpClient.addAuthenticator((Request request) {
      if(UserStore.to.refreshToken == '') return request;
      // 刷新token
      var responseFuture = get(
        "/oauth/token",
        query: {"grant_type": "refresh_token", "refresh_token": userStore.refreshToken},
        headers: {
          "Authorization":
          'Basic ' + base64Encode(utf8.encode('$_client:$_secret'))
        },
      );
      responseFuture.then((response) {
        if (response.statusCode == 200) {
          userStore.setAccessToken(response.body["access_token"]);
          userStore.setRefreshToken(response.body["refresh_token"]);
          request.headers["Authorization"] = "Bearer ${userStore.accessToken}";
        } else {
          print("刷新token失败");
          userStore.onLogout();
        }
      });
      return request;
    });
  }
}
