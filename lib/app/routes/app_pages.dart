import 'package:get/get.dart';

import 'package:get_test/app/modules/home/home_binding.dart';
import 'package:get_test/app/modules/home/home_view.dart';
import 'package:get_test/app/modules/home/widget/team/team_view.dart';
import 'package:get_test/app/modules/login/login_binding.dart';
import 'package:get_test/app/modules/login/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
