import 'dart:convert';

class MeetupsWallModel {
  MeetupsWallModel({
    required this.results,
    required this.articles,
  });

  final String results;
  final List<MeetupsModel> articles;

  factory MeetupsWallModel.fromJson(String str) =>
      MeetupsWallModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MeetupsWallModel.fromMap(Map<String, dynamic> json) {
    return MeetupsWallModel(
      results: json["results"],
      articles: List<MeetupsModel>.from(
        json["articles"].map((x) => MeetupsModel.fromMap(x)),
      ),
    );
  }
  factory MeetupsWallModel.empty() => MeetupsWallModel(
        results: "0",
        articles: [],
      );
  Map<String, dynamic> toMap() => {
        "results": results,
        "articles": List<MeetupsModel>.from(articles.map((x) => x.toMap())),
      };
  @override
  String toString() => toJson();
}

class MeetupsModel {
  MeetupsModel({
    required this.id,
    required this.title,
    required this.url,
    required this.when,
    required this.where,
    required this.author,
    required this.displayName,
    required this.uid_1,
  });

  final String id;
  final String title;
  final String url;
  final DateTime when;
  final String where;
  final String author;
  final String displayName;
  final String uid_1;

  factory MeetupsModel.fromJson(String str) =>
      MeetupsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
  factory MeetupsModel.fromMap(Map<String, dynamic> json) {
    return MeetupsModel(
      id: json["id"],
      title: json["title"],
      url: json["url"],
      when: DateTime.parse(json["when"]),
      where: json["where"],
      author: json["author"],
      displayName: json["display_name"],
      uid_1: json["uid_1"],
    );
  }

  factory MeetupsModel.empty() => MeetupsModel(
        id: "",
        title: "",
        url: "",
        when: DateTime.now(),
        where: "",
        author: "",
        displayName: "",
        uid_1: "",
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "url": url,
        "when": when.toIso8601String(),
        "where": where,
        "author": author,
        "display_name": displayName,
        "uid_1": uid_1,
      };
  @override
  String toString() => toJson();
}
