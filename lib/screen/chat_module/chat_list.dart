import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/constant.dart';
import 'package:sn_2nd/screen/chat_module/controller/chat_controller.dart';
import 'package:sn_2nd/screen/chat_module/controller/chat_list_controller.dart';
import 'package:sn_2nd/screen/chat_module/model/groupIdModel.dart';
import 'package:sn_2nd/screen/chat_module/widget/chat_item.dart';

import 'package:velocity_x/velocity_x.dart';

import 'widget/controller/chat_item_controller.dart';

class ChatList extends StatelessWidget {
  ChatList({Key? key}) : super(key: key);
  ChatListController _chatListController = Get.find();
  ChatController _chatController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
                height: 12.h,
                width: double.infinity,
                color: Colors.blue.shade700,
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: 'My Chat'
                    .text
                    .size(22.sp)
                    .color(Colors.white)
                    .letterSpacing(1)
                    .make()
                    .centered()),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _chatListController.groupList.length,
                  itemBuilder: (context, index) {
                    return chatItem(
                        chatListModel: _chatListController.groupList[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
