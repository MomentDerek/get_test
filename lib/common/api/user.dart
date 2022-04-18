import 'dart:convert';

import 'package:get_test/app/data/model/response.dart';
import 'package:get_test/common/api/base.dart';
import 'package:get_test/common/constant/request.dart';

class UserProvider extends BaseProvider {
  final String _client= OAUTH_CLIENT;
  final String _secret= OAUTH_SECRET;

  Future<ResponseEntity> profile() => get("/api/user/info/")
      .then((value){
   return ResponseEntity.fromJson(value.body);
  });

  Future<ResponseEntity> checkToken(String token) => get(
    "/oauth/check_token",
    query: {"token": token},
    headers: {
      "Authorization":
      'Basic ' + base64Encode(utf8.encode('$_client:$_secret'))
    },
  ).then((value) => ResponseEntity.fromJson(value.body));

  @override
  void onInit(){
    super.onInit();
  }
}
