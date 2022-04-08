import 'dart:convert';

Featuredmodel featuredmodelFromJson(String str) =>
    Featuredmodel.fromJson(json.decode(str));

String featuredmodelToJson(Featuredmodel data) => json.encode(data.toJson());

class Featuredmodel {
  Featuredmodel({
    this.featuredAds,
  });

  List<FeaturedAd>? featuredAds;

  factory Featuredmodel.fromJson(Map<String, dynamic> json) => Featuredmodel(
        featuredAds: List<FeaturedAd>.from(
            json["ads"].map((x) => FeaturedAd.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ads": List<dynamic>.from(featuredAds!.map((x) => x.toJson())),
      };
}

class FeaturedAd {
  FeaturedAd({
    this.id,
    this.category,
    this.subCategory,
    this.title,
    this.description,
    this.adImage,
    this.type,
    this.brand,
    this.yearOfReg,
    this.transmission,
    this.features,
    this.price,
    this.negotiate,
    this.phone,
    this.city,
    this.location,
    this.tag,
    this.subscription,
    this.other,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? category;
  String? subCategory;
  String? title;
  String? description;
  String? adImage;
  String? type;
  String? brand;
  String? yearOfReg;
  String? transmission;
  List<String>? features;
  String? price;
  bool? negotiate;
  String? phone;
  String? city;
  String? location;
  List<String>? tag;
  String? subscription;
  String? other;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory FeaturedAd.fromJson(Map<String, dynamic> json) => FeaturedAd(
        id: json["_id"],
        category: json["category"],
        subCategory: json["subCategory"],
        title: json["title"],
        description: json["description"],
        adImage: json["ad_image"],
        type: json["type"],
        brand: json["brand"],
        yearOfReg: json["year_of_reg"],
        transmission: json["transmission"],
        features: List<String>.from(json["features"].map((x) => x)),
        price: json["price"],
        negotiate: json["negotiate"],
        phone: json["phone"],
        city: json["city"],
        location: json["location"],
        tag: List<String>.from(json["tag"].map((x) => x)),
        subscription: json["subscription"],
        other: json["other"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "category": category,
        "subCategory": subCategory,
        "title": title,
        "description": description,
        "ad_image": adImage,
        "type": type,
        "brand": brand,
        "year_of_reg": yearOfReg,
        "transmission": transmission,
        "features": List<dynamic>.from(features!.map((x) => x)),
        "price": price,
        "negotiate": negotiate,
        "phone": phone,
        "city": city,
        "location": location,
        "tag": List<dynamic>.from(tag!.map((x) => x)),
        "subscription": subscription,
        "other": other,
        "user_id": userId,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
