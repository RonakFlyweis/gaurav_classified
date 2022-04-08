// To parse this JSON data, do
//
//     final allCategorymodel = allCategorymodelFromJson(jsonString);

import 'dart:convert';

List<AllCategorymodel> allCategorymodelFromJson(String str) => List<AllCategorymodel>.from(json.decode(str).map((x) => AllCategorymodel.fromJson(x)));

String allCategorymodelToJson(List<AllCategorymodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllCategorymodel {
  AllCategorymodel({
    this.id,
    this.name,
    this.iconImage,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String ?id;
  String? name;
  String ?iconImage;
  DateTime? createdAt;
  DateTime ?updatedAt;
  int? v;

  factory AllCategorymodel.fromJson(Map<String, dynamic> json) => AllCategorymodel(
    id: json["_id"],
    name: json["name"],
    iconImage: json["iconImage"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "iconImage": iconImage,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
  };
}
