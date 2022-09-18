import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_test/app/modules/home/widget/systemmanage/system_manage_controller.dart';
import 'package:get_test/app/modules/login/widget/custom_textfield_widget.dart';

class SystemManageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put<SystemManageController>(SystemManageController());
    var controller = Get.find<SystemManageController>();
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('创建新用户',style: TextStyle(fontSize: 15),),
              Divider(),
              TextFieldWidget(
                hintText: "输入工作号",
                fontSize: 15,
                iconSize: 15*1.1,
                contentPadding: 18,
                prefixIconData: Icons.person_pin_outlined,
                obscureText: false,
                submit: (value) => {},
                onChanged: (value) => {},
                controller: controller.workIdEditController,
                focusNode: FocusNode(),
              ),
              SizedBox(height: 10,),
              TextFieldWidget(
                hintText: "输入用户名",
                fontSize: 15,
                iconSize: 15*1.1,
                contentPadding: 18,
                prefixIconData: Icons.person_pin_outlined,
                obscureText: false,
                submit: (value) => {},
                onChanged: (value) => {},
                controller: controller.usernameEditController,
                focusNode: FocusNode(),
              ),
              SizedBox(height: 10,),
              TextFieldWidget(
                hintText: "输入密码",
                fontSize: 15,
                iconSize: 15*1.1,
                contentPadding: 18,
                prefixIconData: Icons.person_pin_outlined,
                obscureText: false,
                submit: (value) => {},
                onChanged: (value) => {},
                controller: controller.passwordEditController,
                focusNode: FocusNode(),
              ),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: ()=>controller.updatePassword(), child: Text('提交'))
            ]),
      ),
    );
  }
}
