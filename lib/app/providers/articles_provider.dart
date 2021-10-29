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
      Uri _url = Uri.parse(_baseUrl + "/api/en/v1/wall?filters=yes");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
        WallModel wall = WallModel.fromMap(jsonResponse);
        relatedArticles = wall.articles;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return relatedArticles;
  }
}
