import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/article_user_model.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:http/http.dart' as http;
import 'package:techfrenetic/app/models/group_model.dart';
import 'dart:convert' as json;

import 'package:techfrenetic/app/providers/tf_provider.dart';

class ArticlesProvider extends TechFreneticProvider {
  Future<List<ArticlesModel>> getWall() async {
    List<ArticlesModel> articles = [];

    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/wall?filters=yes");
      var response = await http.get(_url);

      debugPrint("Getting wall information...");
      debugPrint(_url.toString());

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
        WallModel wall = WallModel.fromMap(jsonResponse);
        articles = wall.articles;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }

    return articles;
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

  Future<List<ArticlesModel>> getArticlesByUser(String username) async {
    List<ArticlesModel> articles = [];

    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/wall?filters=yes");
      var response = await http.get(_url);

      debugPrint("Getting articles by user $username ...");
      debugPrint(_url.toString());

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
        WallModel wall = WallModel.fromMap(jsonResponse);

        for (ArticlesModel content in wall.articles) {
          if (content.type == 'Article' && username == content.user) {
            articles.add(content);
          }
        }
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return articles;
  }

  Future<List<ArticlesModel>> getPostsByUser(String username) async {
    List<ArticlesModel> posts = [];

    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/wall?filters=yes");
      var response = await http.get(_url);

      debugPrint("Getting posts by user $username...");
      debugPrint(_url.toString());

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
        WallModel wall = WallModel.fromMap(jsonResponse);

        posts = wall.articles
            .where(
                (content) => content.type == 'Post' && username == content.user)
            .toList();
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return posts;
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
        return true;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return false;
  }

  Future<int?> addArticle(String title, int category, String description,
      String content, String tags, String imageId) async {
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
          {'target_id': imageId, "alt": "Imagen $title"}
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
          {"value": content}
        ],
        "field_tag": [
          {"value": tags}
        ]
      };

      Map<String, String> headers = {};
      headers.addAll(jsonHeader);
      headers.addAll(authHeader);
      headers.addAll(basicAuth);
      headers.addAll(sessionHeader);

      var response = await http.post(_url,
          headers: headers, body: json.jsonEncode(payload));

      if (response.statusCode == 201) {
        var decodedResponse = json.jsonDecode(response.body);
        return decodedResponse["nid"][0]["value"];
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return null;
  }

  Future<ArticlesModel> getArticle(String id) async {
    ArticlesModel article = ArticlesModel.empty();

    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/article/$id");
      debugPrint("Getting article information with id $id...");
      debugPrint(_url.toString());

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

    return article;
  }

  Future<UserByArticleModel> getUserByArticle(String articleUrl) async {
    UserByArticleModel userByArticleModel = UserByArticleModel.empty();

    try {
      Uri _url = Uri.parse("$baseUrl$articleUrl?_format=json");

      var response = await http.get(_url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
        ArticleDetailsModel details = ArticleDetailsModel.fromMap(jsonResponse);
        userByArticleModel = details.revisionUid;
        return userByArticleModel;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return userByArticleModel;
  }

  Future<List<ArticlesModel>> getWallByGroup(GroupModel group) async {
    List<ArticlesModel> articles = [];

    try {
      Uri _url;

      if (group.public) {
        _url = Uri.parse("$baseUrl/api/$locale/v1/wall-public/${group.id}");
      } else {
        _url = Uri.parse("$baseUrl/api/$locale/v1/wall-private/${group.id}");
      }

      var response = await http.get(_url);

      debugPrint("Getting posts by group ${group.id}...");
      debugPrint(_url.toString());

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
