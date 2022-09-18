import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_test/app/modules/home/home_controller.dart';
import 'package:get_test/common/store/user.dart';

class WorkPlaceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var homeController = Get.find<HomeController>();
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            homeController.obx((state) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text('欢迎回来，'+(state?.nickname ?? "用户（请前往设置界面设置昵称）"),style: TextStyle(fontSize: 30),),
                )),
          homeController.obx((state) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text('工作号：'+(state?.workId ?? "工作号获取错误")),
                )),
          homeController.obx((state) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text('邮箱：'+(state?.email ?? "无（请前往设置界面完善）")),
                )),
          homeController.obx((state) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text('电话：'+(state?.phone ?? "无（请前往设置界面完善）")),
                )),
          ],
        ),
      ),
    );
  }
}
