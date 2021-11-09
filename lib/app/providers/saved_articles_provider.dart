import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

import 'package:techfrenetic/app/models/saved_articles_model.dart';

class ArticlesProvider {
  final String _baseUrl = GlobalConfiguration().getValue("api_url");

  Future<List<SavedArticlesModel>> getSavedArticles() async {
    List<SavedArticlesModel> savedArticles = [];

    try {
      Uri _url = Uri.parse(_baseUrl + "/api/en/v1/saved-articles");
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
