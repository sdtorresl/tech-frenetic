import 'dart:convert';
import 'package:techfrenetic/app/models/model.dart';

import 'articles_model.dart';

class SavedArticlesWallModel extends Model {
  SavedArticlesWallModel({
    required this.results,
    required this.articles,
  });

  final int results;
  final List<ArticlesModel> articles;

  factory SavedArticlesWallModel.fromJson(String str) =>
      SavedArticlesWallModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SavedArticlesWallModel.fromMap(Map<String, dynamic> json) {
    return SavedArticlesWallModel(
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
}
