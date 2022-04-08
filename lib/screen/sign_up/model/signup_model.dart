import 'dart:convert';

SignupModel signupModelFromJson(String str) =>
    SignupModel.fromJson(json.decode(str));

String signupModelToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
  SignupModel({
    this.msg,
    this.user,
  });

  String? msg;
  User? user;

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        msg: json["msg"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "user": user!.toJson(),
      };
}

class User {
  User({
    this.username,
    this.email,
    this.password,
    this.phone,
    this.ownership,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? username;
  String? email;
  String? password;
  String? phone;
  String? ownership;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        ownership: json["ownership"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "phone": phone,
        "ownership": ownership,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
