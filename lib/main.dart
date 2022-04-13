import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_test/common/constant/dio.dart';

import 'app/routes/app_pages.dart';
import 'common/utils/storage.dart';
import 'common/request/http_utils.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await initStore();

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      enableLog: true,
    ),
  );
}

Future<void> initStore() async {
  // 初始化本地存储类d
  await SpUtil().init();
  // 初始化request类
  HttpUtils.init(
    baseUrl: DioConstant.BASEURL,
  );
  // 全局注入
  log("全局注入完成");
}
