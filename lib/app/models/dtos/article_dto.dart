import 'dart:convert';

import 'package:techfrenetic/app/models/articles_model.dart';

class ArticleDTO {
  final ArticlesModel article;
  final String locale;

  ArticleDTO({required this.article, this.locale = "en"});

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    Map<String, dynamic> articleMap = {
      'type': [
        {'target_id': "article", 'target_type': "node_type"}
      ],
      'title': [
        {'value': article.title}
      ],
      'langcode': [
        {'value': locale}
      ],
      'field_image': [
        {'target_id': article.image, "alt": article.image}
      ],
      'field_frenetic_content': [
        {'value': true}
      ],
      'field_main_category': [
        {'target_id': article.category}
      ],
      'field_draft': [
        {'value': false}
      ],
      'field_summary': [
        {'value': article.description}
      ],
      "body": [
        {"value": article.body}
      ],
      "field_tag": [
        {"value": article.tags}
      ],
      'field_has_video': [
        {"value": article.video != null}
      ],
      'field_cloudflare_id': [
        {"value": article.video}
      ]
    };
    return articleMap;
  }
}
