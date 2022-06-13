import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/notification_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';
import 'package:http/http.dart' as http;

class NotificationsProvider extends TechFreneticProvider {
  Future<List<NotificationModel>> getNotifications() async {
    List<NotificationModel> notifications = [];

    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/notifications");

      Map<String, String> headers = {};
      headers.addAll(authHeader);
      headers.addAll(sessionHeader);

      debugPrint(_url.toString());
      var response = await http.get(
        _url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        notifications = jsonResponse
            .map((item) => NotificationModel.fromMap(item))
            .toList();
        debugPrint(notifications.toString());
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return notifications;
  }
}
