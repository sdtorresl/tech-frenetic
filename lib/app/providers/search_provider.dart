import 'dart:convert' as json;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/models/user_model.dart';
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

  Future<List<UserModel>> searchUsers(username) async {
    List<UserModel> users = [];
    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/profile-search/$username");

      debugPrint("Getting search users results for $username...");
      debugPrint(_url.toString());

      var response = await http.get(_url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        for (var item in jsonResponse) {
          debugPrint(item.toString());
          UserModel user = UserModel.empty();
          user.uid = int.parse(item['uid']);
          user.userName = item['name'];
          user.name = item['field_name'];

          users.add(user);
        }
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return users;
  }
}
