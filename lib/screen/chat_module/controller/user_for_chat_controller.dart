import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:sn_2nd/constant.dart';
import 'package:sn_2nd/screen/chat_module/constants/chat_constants.dart';
import 'package:sn_2nd/screen/chat_module/model/firebase_user_model.dart';

class UserForChatController extends GetxController {
  final database = FirebaseDatabase.instance.ref();

  addUserInFirebase(
    String name,
    String id,
  ) async {
    final userRef = database.child(ChatConstants.userPath);
    try {
      var body = {
        id: {
          ChatConstants.name: name,
          ChatConstants.userId: id,
        }
      };
      await userRef.update(body);
    } catch (e) {
      print('Error>>>>>' + e.toString());
    }
  }

  addGroupIdInUserFirebase(String userId, String groupId, String name) async {
    final userRef = database
        .child(ChatConstants.userPath)
        .child(userId)
        .child(ChatConstants.groups); //went to user>>userID>>groups
    try {
      var body = {ChatConstants.groupId: groupId, ChatConstants.peerName: name};
      await userRef.child(groupId).update(body);
    } catch (e) {
      print(e.toString());
      throw (e);
    }
  }
}
