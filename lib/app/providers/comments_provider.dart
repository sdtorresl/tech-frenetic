import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/comment_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as json;

class CommentsProvider extends TechFreneticProvider {
  Future<List<CommentModel>> getComments(String articleId,
      {int page = 0}) async {
    List<CommentModel> comments = [];

    try {
      Uri _url = Uri.parse(
          "$baseUrl/api/$locale/v1/comments?_format=json&article=$articleId&page=$page");
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

  Future<bool> addComment(String articleId, String comment) async {
    Uri _url = Uri.parse("$baseUrl/api/$locale/comment?_format=json");

    try {
      Map<String, String> headers = {};
      headers.addAll(authHeader);
      headers.addAll(sessionHeader);
      headers.addAll(jsonHeader);

      String body = json.jsonEncode(
        {
          "entity_id": [
            {"target_id": articleId}
          ],
          "entity_type": [
            {"value": "node"}
          ],
          "comment_type": [
            {"target_id": "comment"}
          ],
          "field_name": [
            {"value": "comment"}
          ],
          "subject": [
            {"value": "Comment $articleId"}
          ],
          "comment_body": [
            {"value": comment, "format": "basic_html"}
          ]
        },
      );

      debugPrint("Posting comment to article $articleId...");

      var response = await http.post(_url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.body);
        return true;
      } else {
        debugPrint(
            "Comment failed to be created: ${response.reasonPhrase}. Status code ${response.statusCode}");
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return false;
  }
}
