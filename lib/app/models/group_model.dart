// To parse this JSON data, do
//
//     final groupModel = groupModelFromMap(jsonString);

import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:techfrenetic/app/models/model.dart';

class GroupModel extends Model {
  GroupModel({
    required this.title,
    required this.description,
    required this.featured,
    required this.members,
    required this.picture,
    required this.id,
    required this.posts,
  });

  String id;
  String title;
  String description;
  String featured;
  String members;
  String picture;
  String posts;

  factory GroupModel.fromJson(String str) =>
      GroupModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GroupModel.fromMap(Map<String, dynamic> json) {
    final String baseUrl = GlobalConfiguration().getValue("api_url");

    return GroupModel(
        id: json["nid"],
        title: json["title"],
        description: json["field_group_description"],
        featured: json["field_group_featured"],
        members: json["field_group_members"],
        picture: json["field_group_logo"].toString().isNotEmpty
            ? baseUrl + json["field_group_logo"]
            : "",
        posts: json["field_group_articles"]);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "featured": featured,
        "members": members,
        "posts": posts,
        "picture": picture
      };

  @override
  String toString() {
    return toJson();
  }
}
