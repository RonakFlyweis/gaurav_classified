import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/constant.dart';
import 'package:sn_2nd/screen/chat_module/chat_screen.dart';
import 'package:sn_2nd/screen/chat_module/controller/chat_controller.dart';
import 'package:sn_2nd/screen/chat_module/model/chat_list_model.dart';
import 'package:sn_2nd/screen/chat_module/widget/controller/chat_item_controller.dart';
import 'package:sn_2nd/web_services/api_provider.dart';
import 'package:velocity_x/velocity_x.dart';

class chatItem extends StatelessWidget {
  chatItem({Key? key, required this.chatListModel}) : super(key: key);
  ChatListModel chatListModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ChatController _chatController = Get.find();
        _chatController.groupId = chatListModel.groupId;
        /*  _chatController.conversationId =
            _chatItemController.conversationModel.id; */
        /* Get.to(() => ChatScreen(
              name: chatListModel.members.party1name == Constants.userName
                  ? chatListModel.members.party2name
                  : chatListModel.members.party1name,
            )); */
        Get.to(() => ChatScreen(
              name: chatListModel.members.nameImageModel!.name,
            ));
      },
      child: Container(
        height: 12.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipOval(
                  child: SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: Image.network(
                      ApiProvider.baseUrl +
                          "/" +
                          (chatListModel.members.nameImageModel!.image ?? ""),
                      fit: BoxFit.cover,
                      errorBuilder: (context, _, __) {
                        return Image.asset('assets/image/health.png',
                            fit: BoxFit.cover);
                      },
                    ),
                  ),
                ),
                4.w.widthBox,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatListModel.members.nameImageModel != null
                          ? chatListModel.members.nameImageModel!.name
                          : "Error :Bad State",
                      /* chatListModel.members.party1name == Constants.userName
                          ? chatListModel.members.party2name
                          : chatListModel.members.party1name, */
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    SizedBox(
                        width: 50.w,
                        child: Text(
                          chatListModel.recentMessage != null
                              ? chatListModel.recentMessage!.messageText
                              : "",
                          style: TextStyle(
                              fontSize: 12.sp, overflow: TextOverflow.ellipsis),
                        )),
                  ],
                ),
              ],
            ),
            Text(
              chatListModel.recentMessage != null
                  ? DateFormat.MMMd()
                      .format(chatListModel.recentMessage!.sentAt)
                  : "",
              style:
                  TextStyle(fontSize: 12.sp, overflow: TextOverflow.ellipsis),
            )
            //'Jul 08'.text.size(12.sp).make(),
          ],
        ),
      ),
    );
  }
}
