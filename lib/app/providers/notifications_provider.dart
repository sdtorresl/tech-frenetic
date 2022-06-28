import 'dart:convert';
import 'dart:io';

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
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return notifications;
  }

  Future<bool> deleteNotification(NotificationModel notification) async {
    try {
      Uri _url = Uri.parse(
          "$baseUrl/api/$locale/admin/structure/notification/${notification.id}?_format=hal_json");

      Map<String, String> headers = {}
        ..addAll(authHeader)
        ..addAll(sessionHeader);

      debugPrint(_url.toString());

      var response = await http.delete(
        _url,
        headers: headers,
      );

      if (response.statusCode == 204) {
        debugPrint("Notification ${notification.id} was deleted");
        return true;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } on SocketException {
      debugPrint('No Internet connection 😑');
    } on FormatException {
      debugPrint("Bad response format 👎");
    }

    return false;
  }
}
