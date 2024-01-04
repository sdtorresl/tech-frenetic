import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:techfrenetic/app/models/notification_model.dart';

import '../enums/notification_type_enum.dart';

final String baseUrl = GlobalConfiguration().getValue("api_url");

class NotificationsMapper {
  static NotificationModel fromJson(String str) => fromMap(json.decode(str));

  static NotificationModel fromMap(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      created: DateTime.parse(json['created']),
      title: json['field_name'],
      useAvatar: json['field_use_avatar'] == "1",
      avatar: json['field_user_avatar'],
      picture: json['user_picture'],
      body: json[
          'notification_text'], //TODO: Generate text from notification type
      read: json['read'] == "1",
      type: _mapStringToNotificationType(json['field_type']),
    );
  }

  static NotificationType _mapStringToNotificationType(String? type) {
    switch (type) {
      case 'commentNotification':
        return NotificationType.like;
      case 'contentNotification':
        return NotificationType.group;
      case 'videoNotification':
        return NotificationType.comment;
      default:
        return NotificationType.follow;
    }
  }

  static String _mapNotificationTypeToString(NotificationType type) {
    switch (type) {
      case NotificationType.group:
        return 'group';
      case NotificationType.comment:
        return 'comment';
      case NotificationType.like:
        return 'like';
      default:
        return 'follow';
    }
  }

  static Map<String, dynamic> toMap(
      NotificationType type, String? userId, int targetId) {
    Map<String, dynamic> body = {
      "field_type": NotificationsMapper._mapNotificationTypeToString(type),
      "user_id": userId,
    };

    switch (type) {
      case NotificationType.like:
      case NotificationType.group:
        body.addAll({
          "nid": targetId,
        });
        break;
      case NotificationType.comment:
      case NotificationType.follow:
      default:
        body.addAll({
          "id_1": targetId,
        });
        break;
    }

    return body;
  }
}
