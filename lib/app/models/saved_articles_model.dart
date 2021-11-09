import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';

class SavedArticlesWallModel {
  SavedArticlesWallModel({
    required this.results,
    required this.articles,
  });

  final int results;
  final List<SavedArticlesModel> articles;

  factory SavedArticlesWallModel.fromJson(String str) =>
      SavedArticlesWallModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SavedArticlesWallModel.fromMap(Map<String, dynamic> json) {
    return SavedArticlesWallModel(
      results: json["results"],
      articles: List<SavedArticlesModel>.from(
        json["articles"].map((x) => SavedArticlesModel.fromMap(x)),
      ),
    );
  }
  Map<String, dynamic> toMap() => {
        "results": results,
        "articles":
            List<SavedArticlesModel>.from(articles.map((x) => x.toMap())),
      };
  @override
  String toString() => toJson();
}

class SavedArticlesModel {
  SavedArticlesModel({
    required this.id,
    required this.title,
    required this.user,
    required this.displayName,
    required this.category,
    required this.thumbnail,
    required this.isVideo,
    required this.video,
    required this.isDraft,
    required this.date,
    required this.slug,
    required this.comments,
    required this.views,
    required this.votes,
    required this.likes,
  });
  final String id;
  final String title;
  final String user;
  final String displayName;
  final String category;
  final String thumbnail;
  final bool isVideo;
  final String video;
  final bool isDraft;
  final DateTime date;
  final String slug;
  final String comments;
  final String views;
  final String votes;
  final String likes;

  factory SavedArticlesModel.fromJson(String str) =>
      SavedArticlesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SavedArticlesModel.fromMap(Map<String, dynamic> json) {
    final String _baseUrl = GlobalConfiguration().getValue("api_url");

    return SavedArticlesModel(
      id: json["id"],
      title: json["title"],
      user: json["user"],
      displayName: json["display_name"],
      category: json["category"],
      thumbnail: _baseUrl + json["thumbnail"],
      isVideo: json["is_video"] == "True",
      video: json["video"],
      isDraft: json["is_draft"] == "True",
      date: DateTime.parse(json["date"]),
      slug: json["slug"],
      comments: json["comments"],
      views: json["views"],
      votes: json["votes"],
      likes: json["likes"],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "user": user,
        "display_name": displayName,
        "category": category,
        "thumbnail": thumbnail,
        "is_video": isVideo,
        "video": video,
        "is_draft": isDraft,
        "date": date.toIso8601String(),
        "slug": slug,
        "comments": comments,
        "views": views,
        "votes": votes,
        "likes": likes,
      };

  @override
  String toString() => toJson();
}
