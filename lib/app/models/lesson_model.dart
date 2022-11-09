import 'package:techfrenetic/app/models/model.dart';

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
  factory LessonModel.fromMap(Map<String, dynamic> json) => LessonModel(
        id: int.parse(json["nid"]),
        title: json["title"],
        videoId: json["field_cloudflare_id"],
        description: json["description"],
      );
}
