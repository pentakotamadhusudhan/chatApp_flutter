// To parse this JSON data, do
//
//     final userLoginModel = userLoginModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserLoginModel userLoginModelFromJson(String str) => UserLoginModel.fromJson(json.decode(str));

String userLoginModelToJson(UserLoginModel data) => json.encode(data.toJson());

class UserLoginModel {
  final int statusCode;
  final Data data;
  final String message;
  final bool hash;

  UserLoginModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.hash,
  });

  factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
    statusCode: json["status_code"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
    hash: json["hash"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "data": data.toJson(),
    "message": message,
    "hash": hash,
  };
}

class Data {
  final int id;
  final DateTime lastLogin;
  final bool isSuperuser;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final bool isStaff;
  final bool isActive;
  final DateTime dateJoined;
  final List<dynamic> groups;
  final List<dynamic> userPermissions;

  Data({
    required this.id,
    required this.lastLogin,
    required this.isSuperuser,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isStaff,
    required this.isActive,
    required this.dateJoined,
    required this.groups,
    required this.userPermissions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    lastLogin: DateTime.parse(json["last_login"]),
    isSuperuser: json["is_superuser"],
    username: json["username"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    isStaff: json["is_staff"],
    isActive: json["is_active"],
    dateJoined: DateTime.parse(json["date_joined"]),
    groups: List<dynamic>.from(json["groups"].map((x) => x)),
    userPermissions: List<dynamic>.from(json["user_permissions"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "last_login": lastLogin.toIso8601String(),
    "is_superuser": isSuperuser,
    "username": username,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "is_staff": isStaff,
    "is_active": isActive,
    "date_joined": dateJoined.toIso8601String(),
    "groups": List<dynamic>.from(groups.map((x) => x)),
    "user_permissions": List<dynamic>.from(userPermissions.map((x) => x)),
  };
}
