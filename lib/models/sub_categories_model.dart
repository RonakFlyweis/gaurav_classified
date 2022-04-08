// To parse this JSON data, do
//
//     final subCategorymodel = subCategorymodelFromJson(jsonString);

import 'dart:convert';

List<SubCategorymodel> subCategorymodelFromJson(String str) => List<SubCategorymodel>.from(json.decode(str).map((x) => SubCategorymodel.fromJson(x)));

String subCategorymodelToJson(List<SubCategorymodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCategorymodel {
  SubCategorymodel({
    this.id,
    this.parentCategory,
    this.name,
    this.iconImage,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String ?id;
  String ?parentCategory;
  String ?name;
  String ?iconImage;
  DateTime ?createdAt;
  DateTime ?updatedAt;
  int ?v;

  factory SubCategorymodel.fromJson(Map<String, dynamic> json) => SubCategorymodel(
    id: json["_id"],
    parentCategory: json["parentCategory"],
    name: json["name"],
    iconImage: json["iconImage"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "parentCategory": parentCategory,
    "name": name,
    "iconImage": iconImage,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
  };
}
