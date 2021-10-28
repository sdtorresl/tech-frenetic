import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';

class ArticlesModel {
  ArticlesModel({
    required this.id,
    required this.title,
    required this.summary,
    required this.category,
    required this.user,
    required this.date,
    required this.slug,
    required this.displayName,
    required this.isPremium,
    required this.comments,
    required this.isVideo,
    required this.duration,
    required this.thumbnail,
    required this.image,
  });

  final String id;
  final String title;
  final String summary;
  final String category;
  final String user;
  final String date;
  final String slug;
  final String displayName;
  final bool isPremium;
  final String comments;
  final bool isVideo;
  final String duration;
  final String thumbnail;
  final String image;

  factory ArticlesModel.fromJson(String str) =>
      ArticlesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ArticlesModel.fromMap(Map<String, dynamic> json) {
    final String _baseUrl = GlobalConfiguration().getValue("api_url");

    return ArticlesModel(
      id: json["id"],
      title: json["title"],
      summary: json["summary"],
      category: json["category"],
      user: json["user"],
      date: json["date"],
      slug: json["slug"],
      displayName: json["display_name"],
      isPremium: json["is_premium"] == "True",
      comments: json["comments"],
      isVideo: json["is_video"] == "True",
      duration: json["duration"],
      thumbnail: _baseUrl + json["thumbnail"],
      image: _baseUrl + json["image"],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "summary": summary,
        "category": category,
        "date": date,
        "slug": slug,
        "display_name": displayName,
        "is_premium": isPremium,
        "comments": comments,
        "is_video": isVideo,
        "duration": duration,
        "thumbnail": thumbnail,
        "image": image,
      };

  @override
  String toString() => toJson();
}
