import 'dart:convert' as json;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';

class SearchProvider extends TechFreneticProvider {
  Future<List<ArticlesModel>> getArticleByTitle(articleTitle) async {
    List<ArticlesModel> articles = [];
    try {
      Uri _url =
          Uri.parse("$baseUrl/api/en/v1/articles-search?title=$articleTitle");

      var response = await http.get(
        _url,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
        WallModel wall = WallModel.fromMap(jsonResponse);
        articles = wall.articles;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return articles;
  }
}
