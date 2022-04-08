// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  MessageModel({
    required this.messageId,
    required this.messageText,
    required this.sentAt,
    required this.sentBy,
  });

  String messageId;
  String messageText;
  DateTime sentAt;
  String sentBy;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        messageId: json["messageId"],
        messageText: json["messageText"],
        sentAt: DateTime.parse(json["sentAt"]),
        sentBy: json["sentBy"],
      );

  Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "messageText": messageText,
        "sentAt": sentAt,
        "sentBy": sentBy,
      };
}
