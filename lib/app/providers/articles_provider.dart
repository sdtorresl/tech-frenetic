import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

import 'package:techfrenetic/app/providers/tf_provider.dart';

class ArticlesProvider extends TechFreneticProvider {
  Future<List<ArticlesModel>> getRelatedArticles() async {
    List<ArticlesModel> relatedArticles = [];

    try {
      Uri _url = Uri.parse(baseUrl + "/api/en/v1/wall?filters=yes");
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

  Future<bool> addPost(String message) async {
    try {
      Uri _url = Uri.parse(baseUrl + "/api/en/v1/node?_format=json");

      /** TODO: Language */
      Map<String, dynamic> payload = {
        'type': [
          {'target_id': "post", 'target_type': "node_type"}
        ],
        'title': [
          {'value': message}
        ],
        'langcode': [
          {'value': 'es'}
        ],
      };

      var response = await http.post(_url, headers: {}, body: payload);

      if (response.statusCode == 200) {
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

  Future<bool> addArticle(ArticlesModel article) async {
    try {
      Uri _url = Uri.parse(baseUrl + "/api/en/v1/node?_format=json");

      /**
      Map<String, dynamic> payload = {
        'type': [
          {'target_id': "article", 'target_type': "node_type"}
        ],
        'title': [
          {'value': article.title}
        ],
        'langcode': [
          {'value': lang}
        ],
        'field_image': [
          {'target_id': image.fid[0].value, 'alt': article.title}
        ],
        'field_frenetic_content': [
          {'value': true}
        ],
        'field_main_category': [
          {'target_id': article.category}
        ],
        'field_summary': [
          {'value': article.description}
        ],
        'field_draft': [
          {'value': false}
        ],
        'body': [
          {'value': article.body}
        ],
      };
      */

      var response = await http.post(_url, headers: {}, body: "");

      if (response.statusCode == 200) {
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
      Uri _url = Uri.parse("$baseUrl/api/en/v1/article?alias=$slug");
      debugPrint("Get article from $_url...");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
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

    debugPrint(article.toString());

    return article;
  }
}
