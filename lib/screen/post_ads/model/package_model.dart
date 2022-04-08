// To parse this JSON data, do
//
//     final packageModel = packageModelFromJson(jsonString);

import 'dart:convert';

List<PackageModel> packageModelFromJson(String str) => List<PackageModel>.from(
    json.decode(str).map((x) => PackageModel.fromJson(x)));

String packageModelToJson(List<PackageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PackageModel {
  PackageModel({
    this.id,
    this.startDate,
    this.endDate,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  DateTime? startDate;
  DateTime? endDate;
  String? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
        id: json["_id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        price: json["price"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "price": price,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
