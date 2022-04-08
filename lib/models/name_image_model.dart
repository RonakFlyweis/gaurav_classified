// To parse this JSON data, do
//
//     final nameImageModel = nameImageModelFromJson(jsonString);

import 'dart:convert';

NameImageModel nameImageModelFromJson(String str) =>
    NameImageModel.fromJson(json.decode(str));

String nameImageModelToJson(NameImageModel data) => json.encode(data.toJson());

class NameImageModel {
  NameImageModel({
    required this.name,
    this.image,
  });

  String name;
  String? image;

  factory NameImageModel.fromJson(Map<String, dynamic> json) => NameImageModel(
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "image": image == null ? null : image,
      };
}
