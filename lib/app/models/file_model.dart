import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:techfrenetic/app/models/model.dart';

class FileModel extends Model {
  FileModel({
    required this.targetId,
    this.alt,
    this.title,
    this.width,
    this.height,
    this.targetType,
    this.targetUuid,
    required this.url,
  }) {
    final String baseUrl = GlobalConfiguration().getValue("api_url");
    url = baseUrl + url;
  }

  int targetId;
  String? alt;
  String? title;
  int? width;
  int? height;
  String? targetType;
  String? targetUuid;
  String url;

  factory FileModel.fromJson(String str) => FileModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FileModel.fromMap(Map<String, dynamic> json) => FileModel(
        targetId: json["target_id"],
        alt: json["alt"],
        title: json["title"],
        width: json["width"],
        height: json["height"],
        targetType: json["target_type"],
        targetUuid: json["target_uuid"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "target_id": targetId,
        "alt": alt,
        "title": title,
        "width": width,
        "height": height,
        "target_type": targetType,
        "target_uuid": targetUuid,
        "url": url,
      };
}
