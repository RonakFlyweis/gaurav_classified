// To parse this JSON data, do
//
//     final pendingAdsModel = pendingAdsModelFromJson(jsonString);

import 'dart:convert';

List<PendingAdsModel> pendingAdsModelFromJson(String str) =>
    List<PendingAdsModel>.from(
        json.decode(str).map((x) => PendingAdsModel.fromJson(x)));

String pendingAdsModelToJson(List<PendingAdsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PendingAdsModel {
  PendingAdsModel({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.category,
    this.subCategory,
    this.adType,
    this.brandName,
    this.yearOfRegistration,
    this.transmission,
    this.features,
    this.price,
    this.negotitate,
    this.mobileNumber,
    this.city,
    this.location,
    this.tag,
    this.status,
    this.date,
    this.expiryDate,
    this.like,
    this.adHiddenFromUser,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? userId;
  String? title;
  String? description;
  String? category;
  String? subCategory;
  String? adType;
  String? brandName;
  String? yearOfRegistration;
  String? transmission;
  String? features;
  String? price;
  String? negotitate;
  String? mobileNumber;
  String? city;
  String? location;
  String? tag;
  int? status;
  String? date;
  String? expiryDate;
  List<dynamic>? like;
  List<dynamic>? adHiddenFromUser;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory PendingAdsModel.fromJson(Map<String, dynamic> json) =>
      PendingAdsModel(
        id: json["_id"],
        userId: json["userId"],
        title: json["title"],
        description: json["description"],
        category: json["category"],
        subCategory: json["subCategory"],
        adType: json["adType"],
        brandName: json["brandName"] == null ? null : json["brandName"],
        yearOfRegistration: json["yearOfRegistration"] == null
            ? null
            : json["yearOfRegistration"],
        transmission:
            json["transmission"] == null ? null : json["transmission"],
        features: json["features"] == null ? null : json["features"],
        price: json["price"],
        negotitate: json["negotitate"],
        mobileNumber: json["mobileNumber"],
        city: json["city"] == null ? null : json["city"],
        location: json["location"],
        tag: json["tag"],
        status: json["status"],
        date: json["date"],
        expiryDate: json["expiryDate"],
        like: List<dynamic>.from(json["like"].map((x) => x)),
        adHiddenFromUser:
            List<dynamic>.from(json["adHiddenFromUser"].map((x) => x)),
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "title": title,
        "description": description,
        "category": category,
        "subCategory": subCategory,
        "adType": adType,
        "brandName": brandName == null ? null : brandName,
        "yearOfRegistration":
            yearOfRegistration == null ? null : yearOfRegistration,
        "transmission": transmission == null ? null : transmission,
        "features": features == null ? null : features,
        "price": price,
        "negotitate": negotitate,
        "mobileNumber": mobileNumber,
        "city": city == null ? null : city,
        "location": location,
        "tag": tag,
        "status": status,
        "date": date,
        "expiryDate": expiryDate,
        "like": List<dynamic>.from(like!.map((x) => x)),
        "adHiddenFromUser": List<dynamic>.from(adHiddenFromUser!.map((x) => x)),
        "image": image,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
