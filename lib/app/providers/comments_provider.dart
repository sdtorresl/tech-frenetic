import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/comment_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as json;

class CommnentsProvider extends TechFreneticProvider {
  Future<List<CommentModel>> getComments(String articleId,
      {int page = 0}) async {
    List<CommentModel> comments = [];

    try {
      Uri _url = Uri.parse(
          "$baseUrl/api/en/v1/comments?_format=json&article=$articleId&page=$page");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
        List commentsResponse = jsonResponse["articles"];
        for (var item in commentsResponse) {
          comments.add(CommentModel.fromMap(item));
        }
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return comments;
  }
}
