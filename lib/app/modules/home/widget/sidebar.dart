
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_test/app/modules/home/home_controller.dart';
import 'package:get_test/common/store/user.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    List<String> menuList = [
      '工作台',
      '团队管理',
      '项目管理',
      '系统管理',
      '我的设置',
    ];
    var userStore = UserStore.to;
    return Drawer(
      backgroundColor: Color.fromARGB(255, 0, 95, 173),
      child: SingleChildScrollView(
        child:  Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      context.theme.secondaryHeaderColor),
                ),
                child: Text(
                  '点击注销',
                  style: TextStyle(color: context.theme.primaryColor),
                ),
                onPressed: () async {
                  await userStore.onLogout();
                  controller.fetchUserInfo();
                },
              ),
            ),
            DrawerListTile(
                title: "工作台",
                svgSrc: "assets/icons/outline/home.svg",
                press: () => controller.switchPage(0)),
            if(userStore.role == 'TEAM_HOST'||userStore.role == 'TEAM_MANAGER')
              DrawerListTile(
                title: "团队管理",
                svgSrc: "assets/icons/outline/inbox.svg",
                press: () => controller.switchPage(menuList.indexOf('团队管理'))),
            if(userStore.role == 'TEAM_HOST'||userStore.role == 'TEAM_MANAGER')
              DrawerListTile(
                  title: "项目管理",
                  svgSrc: "assets/icons/outline/chat.svg",
                  press: () => controller.switchPage(menuList.indexOf('项目管理'))),
            if(userStore.role == 'ADMIN')
              DrawerListTile(
                title: "系统管理",
                svgSrc: "assets/icons/outline/support.svg",
                press: () => controller.switchPage(menuList.indexOf('系统管理'))),
            DrawerListTile(
                title: "我的设置",
                svgSrc: "assets/icons/outline/adjustments.svg",
                press: () => controller.switchPage(menuList.indexOf('我的设置'))),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
}