// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

MessageModel messageModelFromJson(String str) => MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  final int? statusCode;
  final Data? data;
  final String? message;
  final bool? hash;

  MessageModel({
    this.statusCode,
    this.data,
    this.message,
    this.hash,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
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
  final String? message;
  final bool? toLike;
  final bool? fromLike;
  final DateTime? timestamp;
  final int? fromUser;
  final int? toUser;

  Data({
    this.id,
    this.message,
    this.toLike,
    this.fromLike,
    this.timestamp,
    this.fromUser,
    this.toUser,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    message: json["message"],
    toLike: json["to_like"],
    fromLike: json["from_like"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    fromUser: json["from_user"],
    toUser: json["to_user"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "to_like": toLike,
    "from_like": fromLike,
    "timestamp": timestamp?.toIso8601String(),
    "from_user": fromUser,
    "to_user": toUser,
  };
}
