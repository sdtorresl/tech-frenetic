import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';

class WallModel {
  WallModel({
    required this.results,
    required this.articles,
  });

  final String results;
  final List<ArticlesModel> articles;

  factory WallModel.fromJson(String str) => WallModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WallModel.fromMap(Map<String, dynamic> json) {
    return WallModel(
      results: json["results"],
      articles: List<ArticlesModel>.from(
        json["articles"].map((x) => ArticlesModel.fromMap(x)),
      ),
    );
  }
  Map<String, dynamic> toMap() => {
        "results": results,
        "articles": List<ArticlesModel>.from(articles.map((x) => x.toMap())),
      };
  @override
  String toString() => toJson();
}

class ArticlesModel {
  ArticlesModel({
    required this.id,
    required this.title,
    required this.displayName,
    required this.user,
    required this.role,
    required this.summary,
    required this.type,
    required this.date,
    required this.url,
    required this.comments,
    required this.views,
    required this.video,
    required this.category,
    required this.likes,
    required this.image,
    // this.isPremium,
    // this.isVideo,
    // this.duration,
    // this.thumbnail,
  });

  final String id;
  final String title;
  final String displayName;
  final String user;
  final String role;
  final String summary;
  final String type;
  final DateTime date;
  final String url;
  final String comments;
  final String views;
  final String video;
  final String category;
  final String likes;
  final String image;
  // final bool? isPremium;
  // final bool? isVideo;
  // final String? duration;
  // final String? thumbnail;

  factory ArticlesModel.fromJson(String str) =>
      ArticlesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ArticlesModel.fromMap(Map<String, dynamic> json) {
    final String _baseUrl = GlobalConfiguration().getValue("api_url");

    return ArticlesModel(
      id: json["id"],
      title: json["title"],
      displayName: json["display_name"],
      user: json["user"],
      role: json["role"],
      summary: json["summary"],
      type: json["type"],
      date: DateTime.parse(json["date"]),
      url: json["url"],
      comments: json["comments"],
      views: json["views"],
      video: json["video"],
      likes: json["video"],
      image: _baseUrl + json["image"],
      category: json["category"],
      // isPremium: json["is_premium"] == "True",
      // isVideo: json["is_video"] == "True",
      // duration: json["duration"],
      // thumbnail: _baseUrl + json["thumbnail"],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "display_name": displayName,
        "user": user,
        "role": role,
        "summary": summary,
        "type": type,
        "date": date,
        "url": url,
        "comments": comments,
        "views": views,
        "video": video,
        "category": category,
        "likes": likes,
        "image": image,
        // "is_premium": isPremium,
        // "is_video": isVideo,
        // "duration": duration,
        // "thumbnail": thumbnail,
      };

  @override
  String toString() => toJson();
}
