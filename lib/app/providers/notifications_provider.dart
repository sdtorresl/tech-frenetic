import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/user_preferences.dart';
import 'package:techfrenetic/app/models/mappers/notifications_mapper.dart';
import 'package:techfrenetic/app/models/notification_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';
import 'package:http/http.dart' as http;

import '../models/enums/notification_type_enum.dart';

class NotificationsProvider extends TechFreneticProvider {
  Future<List<NotificationModel>> getNotifications() async {
    UserPreferences prefs = UserPreferences();
    List<NotificationModel> notifications = [];

    try {
      Uri _url =
          Uri.parse("$baseUrl/api/custom-notifications/get/${prefs.userId}");

      Map<String, String> headers = {};
      headers.addAll(authHeader);
      headers.addAll(sessionHeader);

      debugPrint(_url.toString());
      var response = await http.get(
        _url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        debugPrint(jsonResponse.toString());

        if (jsonResponse is List<dynamic>) {
          notifications = jsonResponse
              .map((item) => NotificationsMapper.fromMap(item))
              .toList();
        }
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
          "$baseUrl/api/custom-notifications/delete/${notification.id}");

      Map<String, String> headers = {}
        ..addAll(authHeader)
        ..addAll(sessionHeader);

      debugPrint(_url.toString());

      var response = await http.delete(
        _url,
        headers: headers,
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
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

  Future<bool> postNotification({
    String? contentId,
    required NotificationType type,
    required int targetId,
  }) async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/custom-notifications/post");

      Map<String, String> headers = {}
        ..addAll(authHeader)
        ..addAll(sessionHeader)
        ..addAll(halHeader);
      debugPrint(_url.toString());

      Map<String, dynamic> body =
          NotificationsMapper.toMap(type, prefs.userId, targetId);

      var response = await http.post(
        _url,
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Notification was created");
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
