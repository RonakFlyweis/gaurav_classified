// To parse this JSON data, do
//
//     final firebaseUserModel = firebaseUserModelFromJson(jsonString);

import 'dart:convert';

List<FirebaseUserModel> firebaseUserModelFromJson(String str) =>
    List<FirebaseUserModel>.from(
        json.decode(str).map((x) => FirebaseUserModel.fromJson(x)));

String firebaseUserModelToJson(List<FirebaseUserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FirebaseUserModel {
  FirebaseUserModel({
    required this.name,
    required this.groups,
  });

  String name;
  List<String> groups;

  factory FirebaseUserModel.fromJson(Map<String, dynamic> json) =>
      FirebaseUserModel(
        name: json["name"],
        groups: List<String>.from(json["groups"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "groups": List<dynamic>.from(groups.map((x) => x)),
      };
}
