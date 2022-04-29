// To parse this JSON data, do
//
//     final groupModel = groupModelFromMap(jsonString);

import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:techfrenetic/app/models/model.dart';

class GroupModel extends Model {
  GroupModel({
    required this.id,
    required this.title,
    required this.picture,
    this.description,
    this.featured,
    this.members,
    this.posts,
    this.public = true,
  });

  String id;
  String title;
  String? description;
  String? featured;
  String? members;
  String picture;
  String? posts;
  bool public;

  factory GroupModel.fromJson(String str) =>
      GroupModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GroupModel.fromMap(Map<String, dynamic> json) {
    final String baseUrl = GlobalConfiguration().getValue("api_url");

    return GroupModel(
        id: json["id"],
        title: json["label"],
        description: json["field_group_description"],
        featured: json["field_group_featured"],
        members: json["field_group_members"],
        picture: json["field_logo"] != null
            ? json["field_logo"].toString().isNotEmpty
                ? baseUrl + json["field_logo"]
                : ""
            : "",
        posts: json["field_group_articles"] ?? '',
        public: json["type"] == "Group Public");
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "featured": featured,
        "members": members,
        "posts": posts,
        "picture": picture,
        "type": public
      };

  @override
  String toString() {
    return toJson();
  }
}
