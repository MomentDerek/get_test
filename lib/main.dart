import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_test/app/modules/login/login_controller.dart';
import 'package:get_test/common/api/api.dart';
import 'package:get_test/common/api/chat.dart';
import 'package:get_test/common/api/login.dart';
import 'package:get_test/common/service/services.dart';
import 'package:get_test/common/store/user.dart';

import 'app/routes/app_pages.dart';

Future main() async{


  await globalInit();

  runApp(
    GetMaterialApp(
      theme: ThemeData(fontFamily: "SourceHanSansCN"),
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      enableLog: true,
    ),
  );
}

Future<void> globalInit() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Get.putAsync<StorageService>(() => StorageService().init());
  Get.put<LoginProvider>(LoginProvider(),permanent: true);
  await Get.putAsync<UserStore>(()=>UserStore().init());
  Get.put<ChatProvider>(ChatProvider(),permanent: true);

  log("全局注入完成");
}
