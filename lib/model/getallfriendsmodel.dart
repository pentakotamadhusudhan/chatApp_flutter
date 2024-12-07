// To parse this JSON data, do
//
//     final getAllFriendsModel = getAllFriendsModelFromJson(jsonString);

import 'dart:convert';

GetAllFriendsModel getAllFriendsModelFromJson(String str) => GetAllFriendsModel.fromJson(json.decode(str));

String getAllFriendsModelToJson(GetAllFriendsModel data) => json.encode(data.toJson());

class GetAllFriendsModel {
  final int? statusCode;
  final List<Datum>? data;
  final String? message;
  final bool? hash;

  GetAllFriendsModel({
    this.statusCode,
    this.data,
    this.message,
    this.hash,
  });

  factory GetAllFriendsModel.fromJson(Map<String, dynamic> json) => GetAllFriendsModel(
    statusCode: json["status_code"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    message: json["message"],
    hash: json["hash"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "hash": hash,
  };
}

class Datum {
  final int? id;
  final DateTime? lastLogin;
  final bool? isSuperuser;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final bool? isStaff;
  final bool? isActive;
  final DateTime? dateJoined;
  final String? profileImage;
  final String? bio;
  final DateTime? dob;
  final String? nickName;
  final List<dynamic>? groups;
  final List<dynamic>? userPermissions;

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    lastLogin: json["last_login"] == null ? null : DateTime.parse(json["last_login"]),
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
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    nickName: json["nick_name"],
    groups: json["groups"] == null ? [] : List<dynamic>.from(json["groups"]!.map((x) => x)),
    userPermissions: json["user_permissions"] == null ? [] : List<dynamic>.from(json["user_permissions"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "last_login": lastLogin?.toIso8601String(),
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
    "dob":dob==null?"": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "nick_name": nickName,
    "groups": groups == null ? [] : List<dynamic>.from(groups!.map((x) => x)),
    "user_permissions": userPermissions == null ? [] : List<dynamic>.from(userPermissions!.map((x) => x)),
  };
}
