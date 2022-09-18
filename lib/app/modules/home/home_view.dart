import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_test/app/modules/home/home_controller.dart';
import 'package:get_test/app/modules/home/widget/setting/setting_view.dart';
import 'package:get_test/app/modules/home/widget/systemmanage/system_manage_view.dart';
import 'package:get_test/app/modules/home/widget/team/team_view.dart';
import 'package:get_test/app/modules/home/widget/workplace/workplace_view.dart';
import 'package:get_test/common/store/user.dart';
import 'package:get_test/common/widget/constrained_width_flux.dart';

import 'widget/chat/MessageListItem.dart';
import 'widget/sidebar.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    var userStore = Get.find<UserStore>();
    return Scaffold(
      // drawer: ,TODO 边栏
      body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (context.showNavbar && controller.showSideMenu.value)
                ConstrainedWidthFlexible(
                  minWidth: 150,
                  maxWidth: 300,
                  flex: 1,
                  flexSum: 4,
                  outerConstraints: constraints,
                  child: Sidebar(controller: controller),
                ),
              Flexible(
                flex: 2,
                child: PageView(
                  controller: controller.pageViewController,
                  children: [
                    Container(child: WorkPlaceView()),
                    Container(child: TeamManageView()),
                    Container(child: Container(child: Text("项目管理"),)),
                    Container(child: SystemManageView()),
                    Container(child: SettingView()),
                  ],
                ),
              ),
              if (context.width > 1200)
                ConstrainedWidthFlexible(
                    minWidth: 300,
                    maxWidth: 600,
                    flex: 1,
                    flexSum: 4,
                    outerConstraints: constraints,
                    child: Container(
                        decoration:
                            BoxDecoration(color: Color(0xFFE2EAFF), boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0.0, 15.0), //阴影xy轴偏移量
                              blurRadius: 15.0, //阴影模糊程度
                              spreadRadius: 1.0 //阴影扩散程度
                              )
                        ]),
                        child: ChatWidget()))
            ],
          ),
        );
      })),
    );
  }
}

class ChatWidget extends GetView<HomeController> {
  const ChatWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Navigator(
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder = (context) => ChatHomeContainer(controller);
          switch (settings.name) {
            case '/':
              builder = (context) => ChatHomeContainer(controller);
              break;
          }
          controller.chatNavigator = MaterialPageRoute(builder: builder);
          return controller.chatNavigator;
        },
      ),
    );
  }
}

class ChatHomeContainer extends StatelessWidget {
  const ChatHomeContainer(this.controller, {Key? key}) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
          itemCount: controller.chatList.length,
          itemBuilder: (BuildContext context, int index) {
            var chatInfo = controller.chatList[index];
            return MessageListItem(
              index,
              controller,
              chatInfo.workId,
              friendName: chatInfo.nickname,
              latestMessage: chatInfo.lastMessage,
              latestTime: chatInfo.lastTime,
            );
          });
    });
  }
}
