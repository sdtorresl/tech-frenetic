// To parse this JSON data, do
//
//     final groupModel = groupModelFromMap(jsonString);

import 'dart:convert';

import 'package:techfrenetic/app/models/model.dart';

class GroupModel extends Model {
  GroupModel({
    required this.title,
    required this.description,
    required this.featured,
    required this.members,
  });

  String title;
  String description;
  String featured;
  String members;

  factory GroupModel.fromJson(String str) =>
      GroupModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GroupModel.fromMap(Map<String, dynamic> json) => GroupModel(
        title: json["title"],
        description: json["field_group_description"],
        featured: json["field_group_featured"],
        members: json["field_group_members"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
        "featured": featured,
        "members": members,
      };

  @override
  String toString() {
    return toJson();
  }
}
