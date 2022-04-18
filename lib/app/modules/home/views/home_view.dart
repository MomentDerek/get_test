import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:get_test/app/routes/app_pages.dart';
import 'package:get_test/app/modules/home/controllers/home_controller.dart';
import 'package:get_test/common/store/user.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            controller.obx((state) => Text(
              state.toString(),
              style: TextStyle(fontSize: 20),
            )),
            ElevatedButton(
              child: Text('点击注销'),
              onPressed: () async {
                await UserStore.to.onLogout();
                controller.fetchUserInfo();
              },
            ),
            ElevatedButton(
              child: Text('尝试获取信息'),
              onPressed: () {
                controller.fetchUserInfo();
              },
            ),
          ],
        ),
      ),
    );
  }
}
