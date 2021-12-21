import 'dart:io';

import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

import 'package:techfrenetic/app/providers/tf_provider.dart';

class ArticlesProvider extends TechFreneticProvider {
  Future<List<ArticlesModel>> getWall() async {
    List<ArticlesModel> relatedArticles = [];

    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/wall?filters=yes");
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
      rethrow;
    }

    return relatedArticles;
  }

  Future<List<ArticlesModel>> getFeatureArticle() async {
    try {
      Uri _url =
          Uri.parse("$baseUrl/api/$locale/v1/articles-featured?filters=yes");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        List<ArticlesModel> articles = [];
        for (var item in jsonResponse) {
          ArticlesModel article = ArticlesModel.fromMap(item);
          articles.add(article);
          debugPrint(articles.toString());
        }
        return articles;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return [];
  }

  Future<List<ArticlesModel>> getLatestArticle() async {
    List<ArticlesModel> article = [];

    try {
      Uri _url =
          Uri.parse("$baseUrl/api/$locale/v1/articles-latest?filters=yes");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
        WallModel wall = WallModel.fromMap(jsonResponse);
        article = wall.articles;
        debugPrint(article.toString());
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return article;
  }

  Future<List<ArticlesModel>> getMostPopular() async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/articles-popular");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        List<ArticlesModel> articles = [];
        for (var item in jsonResponse) {
          ArticlesModel article = ArticlesModel.fromMap(item);
          articles.add(article);
        }
        return articles;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return [];
  }

  Future<bool> addPost(String message) async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/node?_format=json");

      Map<String, dynamic> payload = {
        "type": [
          {"target_id": "post", "target_type": "node_type"}
        ],
        "title": [
          {"value": message}
        ],
        "langcode": [
          {"value": locale}
        ],
      };

      Map<String, String> headers = {};
      headers.addAll(authHeader);
      headers.addAll(sessionHeader);
      headers['Content-Type'] = 'application/json';

      var response = await http.post(_url,
          headers: headers, body: json.jsonEncode(payload));

      if (response.statusCode == 201) {
        var jsonResponse = json.jsonDecode(response.body);
        debugPrint(jsonResponse.toString());

        return true;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return false;
  }

  Future<bool> addArticle(
    String title,
    int category,
    String description,
  ) async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/entity/node?_format=json");

      Map<String, dynamic> payload = {
        'type': [
          {'target_id': "article", 'target_type': "node_type"}
        ],
        'title': [
          {'value': title}
        ],
        'langcode': [
          {'value': locale}
        ],
        'field_image': [
          {'target_id': '10', "alt": "Imagen base  64 foto"}
        ],
        'field_frenetic_content': [
          {'value': true}
        ],
        'field_main_category': [
          {'target_id': category}
        ],
        'field_draft': [
          {'value': false}
        ],
        'field_summary': [
          {'value': description}
        ],
        "body": [
          {"value": "<p> contenido soporte etiquetas html</p>"}
        ],
        "field_tag": [
          {"value": 'aplications'}
        ]
      };

      Map<String, String> headers = {};
      headers['Content-Type'] = 'application/json';
      headers.addAll(authHeader);
      headers.addAll(sessionHeader);

      debugPrint(payload.toString());
      debugPrint(headers.toString());

      var response = await http.post(_url,
          headers: headers, body: json.jsonEncode(payload));

      if (response.statusCode == 201) {
        Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
        debugPrint(jsonResponse.toString());

        return true;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return false;
  }

  Future<ArticlesModel> getArticle(String slug) async {
    ArticlesModel article = ArticlesModel.empty();

    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/article?alias=$slug");
      debugPrint(_url.toString());
      var response = await http.get(_url);

      if (response.statusCode == 201) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        if (jsonResponse.isNotEmpty) {
          article = ArticlesModel.fromMap(jsonResponse[0]);
        }
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return article;
  }
}
