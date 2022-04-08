import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:sn_2nd/constant.dart';
import 'package:sn_2nd/screen/chat_module/controller/chat_controller.dart';
import 'package:sn_2nd/screen/chat_module/controller/user_for_chat_controller.dart';
import 'package:sn_2nd/screen/chat_module/model/chat_list_model.dart';
import 'package:sn_2nd/screen/chat_module/model/groupIdModel.dart';
import 'package:sn_2nd/web_services/api_provider.dart';
import 'package:uuid/uuid.dart';
import '../constants/chat_constants.dart';
import 'package:async/async.dart' as StreamGroup;

class ChatListController extends GetxController {
  final database = FirebaseDatabase.instance.ref();
  RxList<ChatListModel> groupList = <ChatListModel>[].obs;
  //RxList<String> groupList = <String>[].obs;
  late StreamSubscription groupStream;

  createGroup(String peerId, String peerName) async {
    //group with only two members is private chat
    final groupRef = database.child(ChatConstants.groups);
    try {
      var body = {
        "${Constants.id}-${peerId}": {
          ChatConstants.createdAt: DateTime.now().microsecondsSinceEpoch,
          ChatConstants.createdBy: Constants.id,
          ChatConstants.groupId: "${Constants.id}-${peerId}",
          ChatConstants.members: {
            ChatConstants.party1: Constants.id,
            ChatConstants.party1 + ChatConstants.name: Constants.userName,
            ChatConstants.party2: peerId,
            ChatConstants.party2 + ChatConstants.name: peerName
          },
        }
      };
      UserForChatController userForChatController = Get.find();
      await userForChatController.addGroupIdInUserFirebase(
          Constants.id,
          "${Constants.id}-${peerId}",
          peerName); //adding peers details in usersid
      await userForChatController.addGroupIdInUserFirebase(
          peerId,
          "${Constants.id}-${peerId}",
          Constants.userName); //adding users details in peersid
      await groupRef.set(body);
    } catch (e) {
      print('e>>>>>>' + e.toString());
      throw (e);
    }
  }

  initGroupStream() async {
    groupStream = database
        .child(ChatConstants.userPath)
        .child(Constants.id)
        .child(ChatConstants.groups)
        .onValue
        .listen((event) {
      groupList.clear();
      final tempList = Map<dynamic, dynamic>.from(
          event.snapshot.value as Map<dynamic, dynamic>);
      tempList.forEach((key, value) async {
        //groupList.add(groupIdModelFromJson(jsonEncode(value)));
        final groupIdModel = groupIdModelFromJson(jsonEncode(value));

        final groupData = await database
            .child(ChatConstants.groups)
            .child(groupIdModel.groupId)
            .onValue
            .listen((event) async {
          try {
            groupList.removeWhere((element) =>
                element.groupId ==
                chatListModelFromJson(jsonEncode(event.snapshot.value))
                    .groupId);
          } on Exception catch (e) {}
          try {
            final data =
                chatListModelFromJson(jsonEncode(event.snapshot.value));
            if (data.members.party1 == Constants.id) {
              data.members.nameImageModel =
                  await ApiProvider.getIndividualUserByUserId(
                      data.members.party2);
            } else {
              data.members.nameImageModel =
                  await ApiProvider.getIndividualUserByUserId(
                      data.members.party1);
            }
            groupList.add(data);
          } on Exception catch (e) {}
        });
        /*  
        final groupData = await database
            .child(ChatConstants.groups)
            .child(groupIdModel.groupId)
            .get();
        if (groupData.value != null) {
          groupList.add(chatListModelFromJson(jsonEncode(groupData.value!)));
        } */
      });
      groupList.refresh();
    });
  }

  @override
  void onInit() {
    initGroupStream();
    super.onInit();
  }

  @override
  void onClose() {
    groupStream.cancel();
    super.onClose();
  }
}
