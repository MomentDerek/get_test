import 'package:flutter/material.dart';
import 'package:get_test/app/modules/home/home_controller.dart';
import 'package:get_test/app/modules/home/widget/chat/ChatDetailPage.dart';

final Color color1 = Color(0xFF303133); // 颜色需要使用16进制的，0xFF为固定的前缀
final Color color3 = Color(0xFF526286);
final Color color4 = Color(0xFF2470FF);
final Color red = Color(0xFFFF7C7C);

class MessageListItem extends StatelessWidget {
  MessageListItem(this.index,this.controller,this.friendWorkId,{this.logoUrl,this.friendName,this.latestTime,this.latestMessage});

  HomeController controller;

  int index;
  String friendWorkId;
  String? logoUrl;
  String? friendName;
  String? latestTime;
  String? latestMessage;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ChatDetailPage(controller,friendWorkId);
        }));
      },
      // 绘制列表的最左边项，这里放了个圆形的图片
      leading: Container(
          // 图片宽高
          width: 50,
          height: 50,
          // 描述图片的圆形，需要使用背景图来做
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      logoUrl??'https://upload.jianshu.io/users/upload_avatars/7911324/0a04007f-7e74-4756-9b85-ac1d229d3b5c.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp')))),
      // 绘制消息主体的上半部分，主要是左边的名称和右边的日期，使用row的flex水平布局
      title: Row(
        children: <Widget>[
          Expanded(
              flex: 1, // flex为1就是扩充全部宽度
              child:
                  Text(friendName??friendWorkId, style: TextStyle(color: color1, fontSize: 16))),
          Text(latestTime??'', style: TextStyle(color: color4, fontSize: 12))
        ],
      ),
      // 子标题，给一个向上的5px的间距，同时右边有一个红色的未读消息的标示
      subtitle: Padding(
        padding: EdgeInsets.only(top: 5),
        // 每一个需要两个以上的组件构成的组件，都需要使用Row或者Column或者Flex的组件来实现
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Text(latestMessage??'无消息',
                    style: TextStyle(color: color3, fontSize: 12))),
          ],
        ),
      ),
    );
  }
}