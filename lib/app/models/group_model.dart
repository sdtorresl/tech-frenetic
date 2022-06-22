// To parse this JSON data, do
//
//     final groupModel = groupModelFromMap(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
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
    this.rules,
    this.public = true,
  });

  String id;
  String title;
  String? description;
  String? featured;
  String? members;
  String picture;
  String? posts;
  String? rules;
  bool public;

  factory GroupModel.fromJson(String str) =>
      GroupModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GroupModel.empty() {
    return GroupModel(
        id: "",
        title: "",
        picture:
            "https://dev-techfrenetic.us.seedcloud.co/images/temp/image-detail-group.png");
  }

  factory GroupModel.fromMap(Map<String, dynamic> json) {
    final String baseUrl = GlobalConfiguration().getValue("api_url");

    String picture = "";
    if (json["field_logo"] != null) {
      picture = json["field_logo"].toString().isNotEmpty
          ? baseUrl + json["field_logo"]
          : "";
    }
    if (json["field_group_logo"] != null) {
      picture = json["field_group_logo"].toString().isNotEmpty
          ? baseUrl + json["field_group_logo"]
          : "";
    }

    debugPrint(picture);

    return GroupModel(
        id: json["id"] ?? json["nid"],
        title: json["label"] ?? json["title"],
        description:
            json["field_group_description"] ?? json["field_description"] ?? '',
        featured: json["field_group_featured"] ?? '',
        members: json["field_group_members"] ?? '',
        picture: picture,
        posts: json["field_group_articles"] ?? '',
        rules: json["field_rules"],
        public: json["type"] != null ? json["type"] == "Group Public" : true);
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
