import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

import 'package:techfrenetic/app/models/saved_articles_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';

class ArticlesProvider extends TechFreneticProvider {
  Future<List<ArticlesModel>> getSavedArticles() async {
    List<ArticlesModel> savedArticles = [];

    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/saved-articles");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
        SavedArticlesWallModel wall =
            SavedArticlesWallModel.fromMap(jsonResponse);
        savedArticles = wall.articles;
        debugPrint(savedArticles.toString());
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return savedArticles;
  }
}
