import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/constant.dart';
import 'package:sn_2nd/screen/chat_module/controller/chat_controller.dart';
import 'package:sn_2nd/screen/chat_module/model/message_model.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key, required this.name}) : super(key: key);
  String name;
  ChatController _chatController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // List of messages
              //buildListMessage(),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                      controller: _chatController.listScrollController,
                      physics: BouncingScrollPhysics(),
                      itemCount: _chatController.messageList.length,
                      itemBuilder: ((context, index) => Row(
                            mainAxisAlignment:
                                _chatController.messageList[index].sentBy ==
                                        Constants.id
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.sp),
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: 70.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.sp),
                                      color: Colors.grey.shade200),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.sp),
                                    child: Text(
                                      _chatController
                                          .messageList[index].messageText,
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))),
                ),
              ),

              /* StreamBuilder<List<MessageModel>>(
                  stream: _chatController.getMessageStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: ((context, index) => Row(
                                mainAxisAlignment:
                                    snapshot.data![index].sentBy == Constants.id
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(6.sp),
                                    child: Container(
                                      constraints:
                                          BoxConstraints(maxWidth: 70.w),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.sp),
                                          color: Colors.grey.shade200),
                                      child: Padding(
                                        padding: EdgeInsets.all(6.sp),
                                        child: Text(
                                          snapshot.data![index].messageText,
                                          style: TextStyle(fontSize: 10.sp),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )));
                    } else {
                      return Center(child: Text('No Data'));
                    }
                  }),
 */
              // Input content
              Container(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 5.w,
                    ),
                    Flexible(
                      child: Container(
                        child: TextField(
                          controller: _chatController.messageController,
                          onSubmitted: (value) {
                            _chatController.sendMessage();
                          },
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Type your message...',
                            hintStyle: TextStyle(color: Colors.grey.shade300),
                          ),
                          //focusNode: focusNode,
                        ),
                      ),
                    ),

                    // Button send message
                    Material(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            _chatController.sendMessage();
                          },
                          color: Colors.blue,
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ],
                ),
                width: double.infinity,
                height: 7.h,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: Colors.grey.shade300, width: 0.5)),
                    color: Colors.white),
              )
            ],
          ),
          // Loading
        ],
      ),
    );
  }
}
