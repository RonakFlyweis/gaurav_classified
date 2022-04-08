import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/constant.dart';
import 'package:sn_2nd/screen/chat_module/constants/chat_constants.dart';
import 'package:sn_2nd/screen/chat_module/model/message_model.dart';
import 'package:sn_2nd/web_services/api_provider.dart';
import 'package:uuid/uuid.dart';

import 'package:get/get.dart';

class ChatController extends GetxController {
  TextEditingController messageController = TextEditingController();
  String groupId = '';
  final ScrollController listScrollController = ScrollController();
  int _limit = 20;
  int _limitIncrement = 20;

  _scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange &&
        _limit <= messageList.length) {
      _limit += _limitIncrement;
    }
  }

  final database = FirebaseDatabase.instance.ref();
  RxList<MessageModel> messageList = <MessageModel>[].obs;
  late StreamSubscription _messageStream;

  sendMessage() async {
    print("DDDDDDDDDDDDDDDDDDD  " + groupId);
    final messageRef = database.child(ChatConstants.messages).child(groupId);
    final groupRef = database.child(ChatConstants.groups).child(groupId).child(
        ChatConstants
            .recentMessage); //adding message in group at recent message
    if (messageController.text.isNotEmpty) {
      Uuid uuid = Uuid();
      try {
        var body = {
          ChatConstants.messageId: uuid.v1(),
          ChatConstants.sentBy: Constants.id,
          ChatConstants.sentAt: DateTime.now().toString(),
          ChatConstants.messageText: messageController.text
        };
        await messageRef.push().set(body);
        await groupRef.set(body);
        messageController.clear();
        listScrollController.animateTo(
            listScrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 1),
            curve: Curves.easeIn);
      } catch (e) {
        print('e>>>>>>' + e.toString());
        throw (e);
      }
    }
  }

  initMessageStream() async {
    _messageStream = database
        .child(ChatConstants.messages)
        .child(groupId)
        .limitToLast(_limit)
        .onValue
        .listen((event) {
      messageList.clear();
      final tempList = Map<dynamic, dynamic>.from(
          event.snapshot.value as Map<dynamic, dynamic>);
      tempList.forEach((key, value) {
        value.forEach((key, value2) {
          messageList.add(messageModelFromJson(jsonEncode(value2)));
          messageList.sort((a, b) => a.sentAt.compareTo(b.sentAt));
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent + 10.h,
              duration: Duration(milliseconds: 1),
              curve: Curves.easeIn);
        });
      });
      messageList.refresh();
    });
    listScrollController.addListener(_scrollListener);
  }

  // Stream<List<MessageModel>> getMessageStream() {
  //   final _messageStream = database
  //       .child(ChatConstants.messages)
  //       .child(groupId)
  //       .orderByKey()
  //       .onValue;
  //   final streamToPublish = _messageStream.map((event) {
  //     List<MessageModel> messageList = [];
  //     final tempList = Map<dynamic, dynamic>.from(
  //         event.snapshot.value as Map<dynamic, dynamic>);
  //     tempList.forEach((key, value) {
  //       print('something');
  //       messageList = value.forEach((key, value2) {
  //         return messageModelFromJson(jsonEncode(value2));
  //       }).toList();
  //       print(messageList);
  //     });
  //     return messageList;
  //   });
  //   return streamToPublish;
  // }

  @override
  void onInit() {
    initMessageStream();
    super.onInit();
  }

  @override
  void onClose() {
    _messageStream.cancel();
    listScrollController.dispose();
    super.onClose();
  }
}
