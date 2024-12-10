// To parse this JSON data, do
//
//     final userLoginModel = userLoginModelFromJson(jsonString);

import 'dart:convert';

UserLoginModel userLoginModelFromJson(String str) => UserLoginModel.fromJson(json.decode(str));

String userLoginModelToJson(UserLoginModel data) => json.encode(data.toJson());

class UserLoginModel {
  final int? statusCode;
  final Data? data;
  final String? message;
  final bool? hash;

  UserLoginModel({
    this.statusCode,
    this.data,
    this.message,
    this.hash,
  });

  factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
    statusCode: json["status_code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
    hash: json["hash"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "data": data?.toJson(),
    "message": message,
    "hash": hash,
  };
}

class Data {
  final int? id;
  final dynamic lastLogin;
  final bool? isSuperuser;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final bool? isStaff;
  final bool? isActive;
  final DateTime? dateJoined;
  final dynamic profileImage;
  final String? bio;
  final dynamic dob;
  final String? nickName;
  final List<dynamic>? groups;
  final List<dynamic>? userPermissions;

  Data({
    this.id,
    this.lastLogin,
    this.isSuperuser,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.isStaff,
    this.isActive,
    this.dateJoined,
    this.profileImage,
    this.bio,
    this.dob,
    this.nickName,
    this.groups,
    this.userPermissions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    lastLogin: json["last_login"],
    isSuperuser: json["is_superuser"],
    username: json["username"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    isStaff: json["is_staff"],
    isActive: json["is_active"],
    dateJoined: json["date_joined"] == null ? null : DateTime.parse(json["date_joined"]),
    profileImage: json["profile_image"],
    bio: json["bio"],
    dob: json["dob"],
    nickName: json["nick_name"],
    groups: json["groups"] == null ? [] : List<dynamic>.from(json["groups"]!.map((x) => x)),
    userPermissions: json["user_permissions"] == null ? [] : List<dynamic>.from(json["user_permissions"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "last_login": lastLogin,
    "is_superuser": isSuperuser,
    "username": username,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "is_staff": isStaff,
    "is_active": isActive,
    "date_joined": dateJoined?.toIso8601String(),
    "profile_image": profileImage,
    "bio": bio,
    "dob": dob,
    "nick_name": nickName,
    "groups": groups == null ? [] : List<dynamic>.from(groups!.map((x) => x)),
    "user_permissions": userPermissions == null ? [] : List<dynamic>.from(userPermissions!.map((x) => x)),
  };
}
