import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_test/app/modules/home/widget/setting/setting_controller.dart';
import 'package:get_test/app/modules/login/widget/custom_textfield_widget.dart';

class SettingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put<SettingController>(SettingController());
    var controller = Get.find<SettingController>();
    return Container(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UpdatePasswordWidget(controller: controller),
          SizedBox(height: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('更新资料',style: TextStyle(fontSize: 15),),
              Divider(),
              TextFieldWidget(
                hintText: "昵称",
                fontSize: 15,
                iconSize: 15*1.1,
                contentPadding: 18,
                prefixIconData: Icons.person_pin_outlined,
                obscureText: false,
                submit: (value) => {},
                onChanged: (value) => {},
                controller: controller.nicknameEditController,
                focusNode: FocusNode(),
              ),
              SizedBox(height: 10,),
              TextFieldWidget(
                hintText: "邮箱",
                fontSize: 15,
                iconSize: 15*1.1,
                contentPadding: 18,
                prefixIconData: Icons.mail_outlined,
                obscureText: false,
                submit: (value) => {},
                onChanged: (value) => {},
                controller: controller.mailEditController,
                focusNode: FocusNode(),
              ),
              SizedBox(height: 10,),
              TextFieldWidget(
                hintText: "电话",
                fontSize: 15,
                iconSize: 15*1.1,
                contentPadding: 18,
                prefixIconData: Icons.telegram_outlined,
                obscureText: false,
                submit: (value) => {},
                onChanged: (value) => {},
                controller: controller.phoneEditController,
                focusNode: FocusNode(),
              ),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: ()=>controller.updateInfo(), child: Text('提交')),
            ],
          )
        ],
      ),
    ),);
  }
}

class UpdatePasswordWidget extends StatelessWidget {
  const UpdatePasswordWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SettingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('更新密码',style: TextStyle(fontSize: 15),),
        Divider(),
        TextFieldWidget(
          hintText: "输入旧密码",
          fontSize: 15,
          iconSize: 15*1.1,
          contentPadding: 18,
          obscureText: false,
          submit: (value) => {},
          onChanged: (value) => {},
          controller: controller.oldPasswordEditController,
          focusNode: FocusNode(),
        ),
        SizedBox(height: 10,),
        TextFieldWidget(
          hintText: "输入新密码",
          fontSize: 15,
          iconSize: 15*1.1,
          contentPadding: 18,
          obscureText: false,
          submit: (value) => {},
          onChanged: (value) => {},
          controller: controller.newPasswordEditController,
          focusNode: FocusNode(),
        ),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: ()=>controller.updatePassword(), child: Text('提交')),
      ],
    );
  }
}