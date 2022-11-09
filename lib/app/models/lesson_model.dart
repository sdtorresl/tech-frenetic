import 'package:techfrenetic/app/models/model.dart';
import 'dart:convert';

class LessonModel extends Model {
  final int id;
  final String videoId;
  final String title;
  final String? description;

  LessonModel(
      {required this.id,
      required this.videoId,
      required this.title,
      this.description});

  @override
  factory LessonModel.fromJson(String str) =>
      LessonModel.fromMap(json.decode(str));

  @override
  factory LessonModel.fromMap(Map<String, dynamic> map) => LessonModel(
        id: int.parse(map["nid"]),
        title: map["title"],
        videoId: map["field_cloudflare_id"],
        description: map["description"],
      );
}
