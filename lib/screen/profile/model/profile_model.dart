// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.id,
    this.username,
    this.email,
    this.phone,
    this.password,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.name,
    this.aboutUs,
    this.address,
    this.facebook,
    this.image,
    this.instagram,
    this.website,
  });

  String ?id;
  String ?username;
  String ?email;
  String ?phone;
  String ?password;
  int ?status;
  DateTime ?createdAt;
  DateTime ?updatedAt;
  int ?v;
  String ?name;
  String ?aboutUs;
  String ?address;
  String ?facebook;
  String ?image;
  String ?instagram;
  String ?website;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json["_id"],
    username: json["username"],
    email: json["email"],
    phone: json["phone"],
    password: json["password"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    name: json["name"],
    aboutUs: json["aboutUs"],
    address: json["address"],
    facebook: json["facebook"],
    image: json["image"],
    instagram: json["instagram"],
    website: json["website"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "email": email,
    "phone": phone,
    "password": password,
    "status": status,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
    "name": name,
    "aboutUs": aboutUs,
    "address": address,
    "facebook": facebook,
    "image": image,
    "instagram": instagram,
    "website": website,
  };
}
