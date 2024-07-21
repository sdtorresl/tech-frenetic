import 'package:techfrenetic/app/models/model.dart';

import 'enums/notification_type_enum.dart';

class NotificationModel extends Model {
  NotificationModel({
    this.avatar,
    required this.type,
    required this.title,
    required this.body,
    required this.created,
    this.id = "0",
    this.useAvatar = true,
    this.picture,
    this.read = false,
  }) : assert(avatar != null || picture != null,
            'Either picture or avatar must be provided.');

  String? avatar;
  String? picture;
  NotificationType type;
  String title;
  String body;
  DateTime created;
  String? id;
  bool useAvatar;
  bool read;
}
