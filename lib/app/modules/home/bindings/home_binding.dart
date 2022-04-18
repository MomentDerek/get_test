import 'package:get/get.dart';
import 'package:get_test/common/api/api.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<UserProvider>(()=>UserProvider());
    Get.put<UserProvider>(UserProvider(),permanent: true);
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
