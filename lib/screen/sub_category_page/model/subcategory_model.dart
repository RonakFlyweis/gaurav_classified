/*
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SubcategoryModel subcategoryModelFromJson(String str) =>
    SubcategoryModel.fromJson(json.decode(str));

String subcategoryModelToJson(SubcategoryModel data) =>
    json.encode(data.toJson());

class SubcategoryModel {
  SubcategoryModel({
    this.subCategories,
  });

  List<String>? subCategories;

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) =>
      SubcategoryModel(
        subCategories: List<String>.from(json["subCategories"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "subCategories": List<dynamic>.from(subCategories!.map((x) => x)),
      };
}
*/
