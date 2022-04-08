import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    this.categories,
  });

  List<Category>? categories;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.id,
    this.category,
  });

  String? id;
  String? category;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "category": category,
      };
}
