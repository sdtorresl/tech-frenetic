import 'dart:convert';
import 'dart:io';

import 'package:techfrenetic/app/models/model.dart';

class NotificationModel extends Model {
  NotificationModel({
    required this.avatar,
    this.type,
    required this.name,
    required this.body,
    required this.created,
    this.id = "0",
    this.read = false,
  });

  String avatar;
  String? type;
  String name;
  String body;
  DateTime created;
  String id;
  bool read;

  factory NotificationModel.fromJson(String str) =>
      NotificationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromMap(Map<String, dynamic> json) {
    String avatar = json["user_picture"] ?? 'avatar-01';
    avatar = avatar.isEmpty ? 'avatar-01' : avatar;

    return NotificationModel(
      avatar: avatar,
      type: json["field_type"],
      name: json["user_id"],
      body: json["notification_text"],
      created: DateTime.now()
          .subtract(const Duration(hours: 3)), // TODO: Convert datetime here
      id: json["id"] ?? "ID",
    );
  }

  Map<String, dynamic> toMap() => {
        "user_picture": avatar,
        "field_type": type,
        "user_id": name,
        "notification_text": body,
        "created": created,
        "id": id,
      };
}
