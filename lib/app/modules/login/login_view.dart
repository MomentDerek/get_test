import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_test/app/modules/login/widget/bg/bubble_widget.dart';
import 'package:get_test/app/modules/login/widget/custom_textfield_widget.dart';

import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(children: [
          //背景渐变色
          backgroundColorLayer(),
          //动态气泡
          Positioned.fill(
            child: BubbleWidget(),
          ),
          //背景高斯模糊
          backgroundBlueLayer(),
          Positioned(
            child: Center(
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(context.height / 25)),
                ),
                child: Container(
                  height: context.height / 5 * 4,
                  width: context.height / 5 * 4 / 16 * 9,
                  padding: EdgeInsets.symmetric(
                      horizontal: context.height / 5 * 4/ 20,
                      vertical: context.height / 5 * 4/ 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: context.height / 5 * 4/ 20,
                      ),
                      //标题头
                      loginHeaderWidget(),
                      SizedBox(
                        height: context.height / 5 * 4/ 10,
                      ),
                      //workId输入框
                      loginWorkIdWidget(
                        controller: controller,
                        fontSize: context.width / 60,
                      ),
                      SizedBox(
                        height: context.height / 5 * 4/ 25,
                      ),
                      //密码输入框
                      loginPasswordWidget(
                        controller: controller,
                        fontSize: context.width / 60,
                      ),
                      SizedBox(
                        height: context.height / 5 * 4/ 10,
                      ),
                      //登录按钮
                      Container(
                        height: context.height / 5 * 4/ 20,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => controller.login(),
                          child: Text("登录"),
                        ),
                      ),
                      Expanded(child: Container())
                    ],
                  ),
                ),
              ),
            ),
          ),
          LoginCloseButton()
        ]),
      ),
    );
  }
}

class loginPasswordWidget extends StatelessWidget {
  const loginPasswordWidget(
      {Key? key, required this.controller, required this.fontSize})
      : super(key: key);

  final LoginController controller;
  final fontSize;

  @override
  Widget build(BuildContext context) {
    return Obx(()=>TextFieldWidget(
      hintText: "请输入密码",
      fontSize: fontSize,
      iconSize: fontSize*1.1,
      prefixIconData: Icons.lock_open_outlined,
      suffixIconData: Icons.visibility,
      obscureText: controller.passwordIsObscure.value,
      submit: (value) => {},
      onChanged: (value) => controller.password(value),
      onTap: () => controller.passwordIsObscure.toggle(),
      controller: controller.passwordEditController,
      focusNode: controller.passwordFocusNode,
    ));
  }
}

class loginWorkIdWidget extends StatelessWidget {
  const loginWorkIdWidget(
      {Key? key, required this.controller, required this.fontSize})
      : super(key: key);

  final LoginController controller;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      hintText: "请输入学号/工号",
      fontSize: fontSize,
      iconSize: fontSize*1.1,
      prefixIconData: Icons.person_pin_outlined,
      obscureText: false,
      submit: (value) => {},
      onChanged: (value) => controller.workId(value),
      controller: controller.workIdEditController,
      focusNode: controller.workIdFocusNode,
    );
  }
}

class loginHeaderWidget extends StatelessWidget {
  const loginHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "欢迎回来",
          style: TextStyle(
              fontSize: 40,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

class LoginCloseButton extends StatelessWidget {
  const LoginCloseButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: CloseButton(onPressed: () => Get.back()),
      left: 20,
      top: 20,
    );
  }
}

class backgroundBlueLayer extends StatelessWidget {
  const backgroundBlueLayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(color: Colors.white.withOpacity(0.2))));
  }
}

///背景渐变色
class backgroundColorLayer extends StatelessWidget {
  const backgroundColorLayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.lightBlueAccent.withOpacity(0.3),
          Colors.blue.withOpacity(0.3)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      ),
    );
  }
}
