import 'package:get/get.dart';
import 'package:get_test/common/api/login.dart';

import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController(),permanent: true);
  }
}
