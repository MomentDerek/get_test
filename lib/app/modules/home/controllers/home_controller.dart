import 'package:get/get.dart';
import 'package:get_test/app/data/model/response.dart';
import 'package:get_test/app/data/model/user_info.dart';
import 'package:get_test/common/request/http_utils.dart';

class HomeController extends GetxController {
  
  getUserInfo() async{
    ResponseEntity<dynamic> response = ResponseEntity<dynamic>.fromJson(await HttpUtils.get("/api/user/info/"));
    _responseData.value = response;
  }

  final _responseData = ResponseEntity().obs;

  get responseData => _responseData.value;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getUserInfo();
  }

  @override
  void onClose() {}
}