// To parse this JSON data, do
//
//     final allAddmodel = allAddmodelFromJson(jsonString);

import 'dart:convert';

List<AllAddmodel> allAddmodelFromJson(String str) => List<AllAddmodel>.from(
    json.decode(str).map((x) => AllAddmodel.fromJson(x)));

String allAddmodelToJson(List<AllAddmodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllAddmodel {
  AllAddmodel({
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
    // this.fromItems,
  });

  String? id;
  UserId? userId;
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
  List<dynamic>? image;
  //String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  //List<dynamic>? fromItems;

  factory AllAddmodel.fromJson(Map<String, dynamic> json) => AllAddmodel(
        id: json["_id"],
        userId: UserId.fromJson(json["userId"]),
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
        expiryDate: json["expiryDate"],
        like: List<dynamic>.from(json["like"].map((x) => x)),
        adHiddenFromUser:
            List<dynamic>.from(json["adHiddenFromUser"].map((x) => x)),
        image: List<dynamic>.from(json["image"].map((x) => x)),
        //image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
//fromItems: List<dynamic>.from(json["fromItems"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
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
        "expiryDate": expiryDate,
        "like": List<dynamic>.from(like!.map((x) => x)),
        "adHiddenFromUser": List<dynamic>.from(adHiddenFromUser!.map((x) => x)),
        "image": image,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        // "fromItems": List<dynamic>.from(fromItems!.map((x) => x)),
      };
}

class UserId {
  UserId({
    required this.id,
    required this.username,
  });

  String id;
  String username;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
      };
}
