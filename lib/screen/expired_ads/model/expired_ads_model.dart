// To parse this JSON data, do
//
//     final expiredAdsModel = expiredAdsModelFromJson(jsonString);

import 'dart:convert';

List<ExpiredAdsModel> expiredAdsModelFromJson(String str) =>
    List<ExpiredAdsModel>.from(
        json.decode(str).map((x) => ExpiredAdsModel.fromJson(x)));

String expiredAdsModelToJson(List<ExpiredAdsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpiredAdsModel {
  ExpiredAdsModel({
    this.id,
    this.adId,
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
    this.like,
    this.adHiddenFromUser,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? adId;
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
  List<dynamic>? like;
  List<dynamic>? adHiddenFromUser;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory ExpiredAdsModel.fromJson(Map<String, dynamic> json) =>
      ExpiredAdsModel(
        id: json["_id"],
        adId: json["adId"],
        userId: json["userId"],
        title: json["title"],
        description: json["description"],
        category: json["category"],
        subCategory: json["subCategory"],
        adType: json["adType"],
        brandName: json["brandName"],
        yearOfRegistration: json["yearOfRegistration"],
        transmission: json["transmission"],
        features: json["features"],
        price: json["price"],
        negotitate: json["negotitate"],
        mobileNumber: json["mobileNumber"],
        city: json["city"],
        location: json["location"],
        tag: json["tag"],
        status: json["status"],
        date: json["date"],
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
        "adId": adId,
        "userId": userId,
        "title": title,
        "description": description,
        "category": category,
        "subCategory": subCategory,
        "adType": adType,
        "brandName": brandName,
        "yearOfRegistration": yearOfRegistration,
        "transmission": transmission,
        "features": features,
        "price": price,
        "negotitate": negotitate,
        "mobileNumber": mobileNumber,
        "city": city,
        "location": location,
        "tag": tag,
        "status": status,
        "date": date,
        "like": List<dynamic>.from(like!.map((x) => x)),
        "adHiddenFromUser": List<dynamic>.from(adHiddenFromUser!.map((x) => x)),
        "image": image,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
