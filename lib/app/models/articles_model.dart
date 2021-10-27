import 'dart:convert';

class ArticlesModel {
  ArticlesModel({
    this.id,
    this.title,
    this.summary,
    this.category,
    this.user,
    this.date,
    this.slug,
    this.displayName,
    this.isPremium,
    this.comments,
    this.isVideo,
    this.duration,
    this.thumbnail,
    this.image,
  });

  final String? id;
  final String? title;
  final String? summary;
  final String? category;
  final String? user;
  final String? date;
  final String? slug;
  final String? displayName;
  final bool? isPremium;
  final String? comments;
  final bool? isVideo;
  final String? duration;
  final String? thumbnail;
  final String? image;

  factory ArticlesModel.fromJson(String str) =>
      ArticlesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ArticlesModel.fromMap(Map<String, dynamic> json) => ArticlesModel(
        id: json["id"],
        title: json["title"],
        summary: json["summary"],
        category: json["category"],
        user: json["user"],
        date: json["date"],
        slug: json["slug"],
        displayName: json["display_name"],
        isPremium: json["is_premium"],
        comments: json["comments"],
        isVideo: json["is_video"] == "1",
        duration: json["duration"],
        thumbnail: json["thumbnail"],
        image: json["image"],
      );

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
        "imag?e": image,
      };

  @override
  String toString() => this.toJson();
}
