// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:global_configuration/global_configuration.dart';

import 'lesson_model.dart';
import 'model.dart';

class CourseModel extends Model {
  CourseModel({
    required this.picture,
    required this.title,
    required this.id,
    required this.description,
    this.owner,
    this.lessons,
  });

  String picture;
  String title;
  String id;
  String? owner;
  String description;
  List<LessonModel>? lessons;

  factory CourseModel.fromMap(Map<String, dynamic> json) {
    final String baseUrl = GlobalConfiguration().getValue("api_url");

    return CourseModel(
      picture: baseUrl + json["field_imagen_courses"],
      title: json["title"],
      id: json["nid"],
      owner: json["uid"],
      description: json["field_description"],
      lessons: json["lessons"],
    );
  }

  Map<String, dynamic> toJson() => {
        "field_imagen_courses": picture,
        "title": title,
        "nid": id,
        "uid": owner,
        "field_description": description,
      };
}
