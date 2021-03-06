// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.accessToken,
    this.email,
    this.idToken,
    this.image,
    this.name,
    this.phoneNumber,
    this.walletBalance,
  });

  String accessToken;
  String email;
  String idToken;
  String image;
  String name;
  String phoneNumber;
  int walletBalance;

  factory User.fromJson(Map<String, dynamic> json) => User(
        accessToken: json["accessToken"] == null ? null : json["accessToken"],
        email: json["email"] == null ? null : json["email"],
        idToken: json["idToken"] == null ? null : json["idToken"],
        image: json["image"] == null ? null : json["image"],
        name: json["name"] == null ? null : json["name"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        walletBalance: json["walletBalance"] == null ? null : json["walletBalance"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken == null ? null : accessToken,
        "email": email == null ? null : email,
        "idToken": idToken == null ? null : idToken,
        "image": image == null ? null : image,
        "name": name == null ? null : name,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "walletBalance": walletBalance == null ? null : walletBalance,
      };
}

class AppUser {
  String id;
  String accessToken;
  String email;
  String idToken;
  String image;
  String name;
  String phoneNumber;
  Map<String, dynamic> votedPolls;
  bool hasVoted;

  AppUser({
    this.id,
    this.accessToken,
    this.email,
    this.idToken,
    this.image,
    this.name,
    this.phoneNumber,
    this.votedPolls,
    this.hasVoted,
  });
}
