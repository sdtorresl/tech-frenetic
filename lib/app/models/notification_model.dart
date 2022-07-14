import 'dart:convert';

import 'package:techfrenetic/app/models/model.dart';

enum NotificationType {
  groupNotification,
  commentNotification,
  contentNotification,
  videoNotification,
  sharedNotification
}

class NotificationModel extends Model {
  NotificationModel({
    required this.avatar,
    this.type,
    required this.name,
    required this.body,
    required this.created,
    this.id = "0",
    this.useAvatar = true,
    this.picture,
  });

  String avatar;
  String? picture;
  String? type;
  String name;
  String body;
  DateTime created;
  String id;
  bool useAvatar;

  factory NotificationModel.fromJson(String str) =>
      NotificationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromMap(Map<String, dynamic> json) {
    String avatar = json["field_user_avatar"] ?? 'avatar-01';
    avatar = avatar.isEmpty ? 'avatar-01' : avatar;

    return NotificationModel(
      type: json["field_type"],
      name: json["user_id"],
      body: json["notification_text"],
      created: DateTime.parse(json["created"]),
      id: json["id"],
      useAvatar: json["field_use_avatar"] == "true",
      avatar: avatar,
      picture: json["user_picture"],
    );
  }

  Map<String, dynamic> toMap() => {
        "user_picture": avatar,
        "field_type": type,
        "user_id": name,
        "notification_text": body,
        "created": created.toIso8601String(),
        "id": id,
      };

  @override
  String toString() {
    return toJson();
  }
}
