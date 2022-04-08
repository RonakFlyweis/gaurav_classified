// To parse this JSON data, do
//
//     final chatListModel = chatListModelFromJson(jsonString);

import 'dart:convert';

import 'package:sn_2nd/models/name_image_model.dart';
import 'package:sn_2nd/screen/chat_module/model/message_model.dart';

ChatListModel chatListModelFromJson(String str) =>
    ChatListModel.fromJson(json.decode(str));

String chatListModelToJson(ChatListModel data) => json.encode(data.toJson());

class ChatListModel {
  ChatListModel({
    required this.createdAt,
    required this.createdBy,
    required this.groupId,
    required this.members,
    this.recentMessage,
  });

  int createdAt;
  String createdBy;
  String groupId;
  Members members;
  MessageModel? recentMessage;

  factory ChatListModel.fromJson(Map<String, dynamic> json) => ChatListModel(
        createdAt: json["createdAt"],
        createdBy: json["createdBy"],
        groupId: json["groupId"],
        members: Members.fromJson(json["members"]),
        recentMessage: json["recentMessage"] != null
            ? MessageModel.fromJson(json["recentMessage"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "createdBy": createdBy,
        "groupId": groupId,
        "members": members.toJson(),
        "recentMessage": recentMessage!.toJson(),
      };
}

class Members {
  Members(
      {required this.party1,
      required this.party2,
      //required this.party1name,
      this.nameImageModel
      //required this.party2name
      });

  String party1;
  //String party1name;
  NameImageModel? nameImageModel;
  String party2;
  //String party2name;

  factory Members.fromJson(Map<String, dynamic> json) => Members(
        party1: json["party1"],
        //party1name: json["party1name"],
        party2: json["party2"],

        //party2name: json["party2name"],
      );

  Map<String, dynamic> toJson() => {
        "party1": party1,
        //"party1name": party1name,
        "party2": party2,
        //"party2name": party2name,
      };
}
