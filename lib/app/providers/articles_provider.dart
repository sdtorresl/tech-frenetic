import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

class ArticlesProvider {
  final String _baseUrl = GlobalConfiguration().getValue("api_url");

  Future<List<ArticlesModel>> getRelatedArticles() async {
    List<ArticlesModel> relatedArticles = [];

    try {
      Uri _url = Uri.parse(_baseUrl + "/api/en/v1/articles-related");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);

        for (var item in jsonResponse) {
          ArticlesModel article = ArticlesModel.fromMap(item);
          relatedArticles.add(article);
        }
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return relatedArticles;
  }
}
