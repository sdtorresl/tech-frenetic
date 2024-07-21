import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techfrenetic/app/models/like_model.dart';
import 'package:techfrenetic/app/providers/notifications_provider.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';

import '../models/enums/notification_type_enum.dart';

class LikeProvider extends TechFreneticProvider {
  String? dislikeId;

  Future<LikeModel?> like(
    String id,
  ) async {
    LikeModel? likeModel;

    NotificationsProvider _notificationsProvider = NotificationsProvider();

    try {
      Uri _url = Uri.parse("$baseUrl/api/entity/vote/?_format=json");

      Map<String, dynamic> body = {
        "entity_id": [
          {"target_id": id}
        ],
        "entity_type": [
          {"value": "node"}
        ],
        "field_name": [
          {"value": "field_like_dislike"}
        ],
        "type": [
          {"target_id": "like", "target_type": "vote_type"}
        ],
        "value": [
          {"value": 1}
        ],
        "value_type": [
          {"value": "percent"}
        ]
      };

      Map<String, String> headers = {};
      headers.addAll(authHeader);
      headers.addAll(jsonHeader);
      headers.addAll(sessionHeader);
      headers.addAll(headers);

      var response = await http.post(
        _url,
        body: json.encode(body),
        headers: headers,
      );

      if (response.statusCode == 201) {
        likeModel = LikeModel.fromJson(response.body);

        _notificationsProvider.postNotification(
          type: NotificationType.like,
          targetId: likeModel.id,
        );

        return likeModel;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<bool> dislike() async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/entity/vote/$dislikeId?_format=json");

      Map<String, String> headers = {};
      headers.addAll(authHeader);
      headers.addAll(jsonHeader);
      headers.addAll(sessionHeader);
      headers.addAll(headers);

      var response = await http.delete(
        _url,
        headers: headers,
      );
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);

      if (response.statusCode == 204) {
        debugPrint('deleated');
        return true;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }
}
