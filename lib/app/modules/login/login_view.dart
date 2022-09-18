import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_test/app/modules/login/widget/bg/bubble_widget.dart';
import 'package:get_test/app/modules/login/widget/custom_textfield_widget.dart';

import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    double cardHeight = context.height / 5 * 4;
    double cardWidth = cardHeight / 16 * 9;
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                    height: cardHeight,
                    width: cardWidth,
                    padding: EdgeInsets.symmetric(
                        horizontal: cardHeight/ 20,
                        vertical: cardHeight/ 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: cardHeight/ 20,
                        ),
                        //标题头
                        loginHeaderWidget(fontSize:cardWidth/10 ),
                        SizedBox(
                          height: cardHeight/ 5,
                        ),
                        //workId输入框
                        loginWorkIdWidget(
                          controller: controller,
                          fontSize: cardWidth / 24,
                          contentPadding: cardWidth/20,
                        ),
                        SizedBox(
                          height: cardHeight/ 25,
                        ),
                        //密码输入框
                        loginPasswordWidget(
                          controller: controller,
                          fontSize: cardWidth/ 24,
                          contentPadding: cardWidth/20,
                        ),
                        SizedBox(
                          height: cardHeight/ 4,
                        ),
                        //登录按钮
                        Container(
                          height: cardHeight/ 20,
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
      ),
    );
  }
}

class loginPasswordWidget extends StatelessWidget {
  const loginPasswordWidget(
      {Key? key, required this.controller, required this.fontSize ,required this.contentPadding})
      : super(key: key);

  final double contentPadding;
  final LoginController controller;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Obx(()=>TextFieldWidget(
        hintText: "请输入密码",
        fontSize: fontSize,
        iconSize: fontSize*1.1,
      contentPadding: contentPadding,

      prefixIconData: Icons.lock_open_outlined,
        suffixIconData: Icons.visibility,
        obscureText: controller.passwordIsObscure.value,
        submit: (value) => {},
        onChanged: (value) => controller.password(value),
        onTap: () => controller.passwordIsObscure.toggle(),
        controller: controller.passwordEditController,
        focusNode: controller.passwordFocusNode,
      ),
    );
  }
}

class loginWorkIdWidget extends StatelessWidget {
  const loginWorkIdWidget(
      {Key? key, required this.controller, required this.fontSize,required this.contentPadding})
      : super(key: key);

  final double contentPadding;
  final LoginController controller;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
        hintText: "请输入学号/工号",
        fontSize: fontSize,
        iconSize: fontSize*1.1,
        contentPadding: contentPadding,
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
    double this.fontSize = 40
  }) : super(key: key);

  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "欢迎回来",
          style: TextStyle(
              fontSize: fontSize,
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
