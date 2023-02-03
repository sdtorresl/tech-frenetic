import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';

class WallModel {
  WallModel({
    required this.results,
    required this.articles,
  });

  final dynamic results;
  final List<ArticlesModel> articles;

  factory WallModel.fromJson(String str) => WallModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WallModel.fromMap(Map<String, dynamic> json) {
    return WallModel(
      results: json["results"] ?? '0',
      articles: List<ArticlesModel>.from(
        json["articles"].map((x) => ArticlesModel.fromMap(x)),
      ),
    );
  }

  factory WallModel.empty() => WallModel(
        results: "0",
        articles: [],
      );

  Map<String, dynamic> toMap() => {
        "results": results,
        "articles": List<ArticlesModel>.from(articles.map((x) => x.toMap())),
      };
  @override
  String toString() => toJson();
}

enum ArticleType { post, article }

class ArticlesModel {
  ArticlesModel({
    required this.displayName,
    required this.id,
    required this.title,
    this.body,
    this.category,
    this.comments = 0,
    this.date,
    this.description,
    this.duration,
    this.image,
    this.isPremium = false,
    this.isVideo = true,
    this.likes,
    this.role,
    this.summary,
    this.tags,
    this.thumbnail,
    this.type,
    this.uid,
    this.url,
    this.user,
    this.video,
    this.videoId,
    this.views,
    this.votes,
  });

  final String id;
  final String title;
  final String displayName;
  final String? user;
  final String? role;
  final String? summary;
  final ArticleType? type;
  final DateTime? date;
  final String? description;
  final String? url;
  final int comments;
  final String? views;
  final String? video;
  final String? category;
  final String? likes;
  final String? image;
  final bool isPremium;
  final bool isVideo;
  final String? duration;
  final String? thumbnail;
  final String? body;
  final String? votes;
  final String? uid;
  final String? videoId;
  final String? tags;

  factory ArticlesModel.fromJson(String str) =>
      ArticlesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ArticlesModel.fromMap(Map<String, dynamic> json) {
    final String _baseUrl = GlobalConfiguration().getValue("api_url");

    ArticleType type = json["type"] != null
        ? ArticleType.values.firstWhere(
            (e) => e.name.toString() == (json["type"] as String).toLowerCase(),
            orElse: () => ArticleType.post)
        : ArticleType.article;

    var isVideo = json["field_cloudflare_id"] != null
        ? (json["field_cloudflare_id"] as String).isNotEmpty
        : json["is_video"] == "True";

    return ArticlesModel(
        id: json["id"],
        title: json["title"],
        displayName: json["display_name"],
        user: json["user"],
        role: json["role"],
        summary: json["summary"],
        type: type,
        date: DateTime.parse(json["date"]),
        url: json["url"],
        comments: int.tryParse(json["comments"]) ?? 0,
        views: json["views"],
        video: json["video"],
        likes: json["likes"],
        image: json["image"] != null && json["image"] != ""
            ? _baseUrl + json["image"]
            : null,
        category: json["category"],
        isPremium: json["is_premium"] == "True",
        isVideo: isVideo,
        duration: json["duration"],
        thumbnail: json["thumbnail"] != null && json["thumbnail"] != ""
            ? _baseUrl + json["thumbnail"]
            : null,
        body: json["body"],
        votes: json["votes"],
        uid: json["uid"] ?? json["uid_1"],
        videoId: json["field_cloudflare_id"]);
  }

  factory ArticlesModel.empty() => ArticlesModel(
      id: "",
      title: "",
      displayName: "",
      user: "",
      role: "",
      summary: "",
      type: ArticleType.article,
      date: null,
      url: "",
      comments: 0,
      views: "",
      video: "",
      category: "",
      likes: "",
      image: null,
      body: "",
      votes: "",
      uid: "");

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "display_name": displayName,
        "user": user,
        "role": role,
        "summary": summary,
        "type": type?.name,
        "date": date != null ? date!.toIso8601String() : null,
        "url": url,
        "comments": comments,
        "views": views,
        "video": video,
        "category": category,
        "likes": likes,
        "image": image,
        "is_premium": isPremium,
        "is_video": isVideo,
        "duration": duration,
        "thumbnail": thumbnail,
        "body": body,
        "votes": votes,
        "uid": uid
      };

  @override
  String toString() => toJson();
}
