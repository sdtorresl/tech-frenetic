import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:techfrenetic/app/models/articles_related_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

class ArticlesProvider {
  final String _baseUrl = GlobalConfiguration().getValue("api_url");

  Future<List<ArticlesReleted>> getRelatedArticles() async {
    List<ArticlesReleted> relatedArticles = [];

    try {
      Uri _url =
          Uri.parse(_baseUrl + "/en/v1/articles-related/articles-related");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        debugPrint(response.body);

        List<dynamic> jsonResponse = json.jsonDecode(response.body);

        for (var item in jsonResponse) {
          ArticlesReleted article = ArticlesReleted.fromMap(item);
          relatedArticles.add(article);
        }
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } on Exception {
      debugPrint("Unexpected error");
    }

    return relatedArticles;
  }
}