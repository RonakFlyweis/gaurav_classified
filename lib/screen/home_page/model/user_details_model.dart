// To parse this JSON data, do
//
//     final userDetailsModel = userDetailsModelFromJson(jsonString);

import 'dart:convert';

UserDetailsModel userDetailsModelFromJson(String str) =>
    UserDetailsModel.fromJson(json.decode(str));

String userDetailsModelToJson(UserDetailsModel data) =>
    json.encode(data.toJson());

class UserDetailsModel {
  UserDetailsModel({
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

  String? id;
  String? username;
  String? email;
  String? phone;
  String? password;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? name;
  String? aboutUs;
  String? address;
  String? facebook;
  String? image;
  String? instagram;
  String? website;

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      UserDetailsModel(
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
