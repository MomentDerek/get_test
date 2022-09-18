import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_test/app/modules/home/home_controller.dart';
import 'package:get_test/app/modules/home/widget/team/team_controller.dart';
import 'package:get_test/app/modules/login/widget/custom_textfield_widget.dart';

class TeamManageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put<TeamManageController>(TeamManageController());
    var controller = Get.find<TeamManageController>();
    return Column(
      children: [SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('将新成员加入团队',style: TextStyle(fontSize: 15),),
              Divider(),
              TextFieldWidget(
                hintText: "学号/工号",
                fontSize: 15,
                iconSize: 15*1.1,
                contentPadding: 18,
                prefixIconData: Icons.person_pin_outlined,
                obscureText: false,
                submit: (value) => {},
                onChanged: (value) => {},
                controller: controller.inviteEditController,
                focusNode: FocusNode(),
              ),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: ()=>controller.inviteInTeam(), child: Text('加入')),
            ],
          ),
        ),
        Obx(() => DataTable(
              columns: [
                for (var i in controller.columnNames) DataColumn(label: Text(i))
              ],
              rows: [
                for (var i = 0; i < controller.memberList.length; i++)
                  DataRow(cells: [
                    DataCell(
                      InkWell(
                        child:
                            Container(child: Text(controller.memberList[i].workId)),
                        onTap: () => HomeController.to
                            .jumpToChat(controller.memberList[i].workId),
                      ),
                    ),
                    DataCell(TextFormField(
                      decoration: InputDecoration(border: InputBorder.none),
                      initialValue: controller.memberList[i].nickname.toString(),
                      onFieldSubmitted: (text) {
                        controller.memberList[i].nickname = text;
                        controller.updateRow(i, controller.memberList[i]);
                      },
                    )),
                    DataCell(TextFormField(
                      decoration: InputDecoration(border: InputBorder.none),
                      initialValue: controller.memberList[i].phone.toString(),
                      onFieldSubmitted: (text) {
                        controller.memberList[i].phone = text;
                        controller.updateRow(i, controller.memberList[i]);
                      },
                    )),
                    DataCell(TextFormField(
                      decoration: InputDecoration(border: InputBorder.none),
                      initialValue: controller.memberList[i].email.toString(),
                      onFieldSubmitted: (text) {
                        controller.memberList[i].email = text;
                        controller.updateRow(i, controller.memberList[i]);
                      },
                    )),
                    DataCell(Text(controller.memberList[i].teamMemberRoles.name))
                  ])
              ],
            )),
      ],
    );
  }
}

List<DataCell> cells = [];
