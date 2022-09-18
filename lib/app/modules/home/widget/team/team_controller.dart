import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_test/app/modules/home/home_controller.dart';
import 'package:get_test/common/api/team.dart';
import 'package:get_test/common/entity/team_member.dart';
import 'package:get_test/common/store/user.dart';
import 'package:meta/meta.dart';

class TeamManageController extends GetxController {
  static TeamManageController get to => Get.find();

  TextEditingController inviteEditController = TextEditingController();

  var memberList = <TeamMemberEntity>[].obs;

  List<String> columnNames = ['学号/工号', '姓名', '手机号', '邮箱', '角色'];

  @override
  void onInit() async {
    super.onInit();
    Get.put<TeamProvider>(TeamProvider());
    var responseEntity = await Get.find<TeamProvider>().fetchTeamMemberList();
    memberList(List<TeamMemberEntity>.from(
        responseEntity.data.map((e) => TeamMemberEntity.fromJson(e))));
  }

  void updateRow(int index, TeamMemberEntity entity) {
    memberList[index] = entity;
    updateRowToServer(index, entity);
  }

  void updateRowToServer(int index, TeamMemberEntity entity) async {
    var responseEntity =
        await Get.find<TeamProvider>().updateTeamMember(entity);
    if (responseEntity.code != 200) {
      Get.snackbar('更新失败', responseEntity.data.toString(),
          backgroundColor: Colors.black26, duration: Duration(seconds: 1));
    } else {
      Get.snackbar('更新成功', entity.workId + '的信息已更新',
          backgroundColor: Colors.black26, duration: Duration(seconds: 1));
      var homeController = HomeController.to;
      homeController.fetchChatList();
      homeController.update();
      await UserStore.to.getProfile();
      homeController.change(UserStore.to.profile, status: RxStatus.success());
    }
  }

  void inviteInTeam() async {
    var responseEntity = await TeamProvider.to
        .inviteTeamMember(inviteEditController.text, UserStore.to.teamName);
    if (responseEntity.code != 200) {
      Get.snackbar('加入失败', responseEntity.data.toString(),
          backgroundColor: Colors.black26, duration: Duration(seconds: 1));
      return;
    }
    Get.snackbar('加入成功', inviteEditController.text+"已加入团队",
        backgroundColor: Colors.black26, duration: Duration(seconds: 1));
    inviteEditController.clear();
    responseEntity = await Get.find<TeamProvider>().fetchTeamMemberList();
    memberList(List<TeamMemberEntity>.from(
        responseEntity.data.map((e) => TeamMemberEntity.fromJson(e))));
  }
}
