// To parse this JSON data, do
//
//     final groupIdModel = groupIdModelFromJson(jsonString);

import 'dart:convert';

GroupIdModel groupIdModelFromJson(String str) =>
    GroupIdModel.fromJson(json.decode(str));

String groupIdModelToJson(GroupIdModel data) => json.encode(data.toJson());

class GroupIdModel {
  GroupIdModel({
    required this.groupId,
    required this.peerName,
  });

  String groupId;
  String peerName;

  factory GroupIdModel.fromJson(Map<String, dynamic> json) => GroupIdModel(
        groupId: json["groupId"],
        peerName: json["peerName"],
      );

  Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "peerName": peerName,
      };
}
