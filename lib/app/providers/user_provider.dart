import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techfrenetic/app/models/session_model.dart';
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';

class UserProvider extends TechFreneticProvider {
  SessionModel? loggedUser;

  Future<SessionModel?> login(String email, String password) async {
    SessionModel? loggedUser;

    try {
      Uri _url = Uri.parse("$baseUrl/api/user/login?_format=json");

      String body = json.encode({'name': email, 'pass': password});

      var response = await http.post(
        _url,
        body: body,
        headers: <String, String>{'content-type': 'application/json'},
      );

      if (response.statusCode == 200) {
        updateCookie(response);
        loggedUser = SessionModel.fromJson(response.body);

        debugPrint(loggedUser.toString());

        prefs.csrfToken = loggedUser.csrfToken;
        prefs.logoutToken = loggedUser.logoutToken;
        prefs.userId = loggedUser.currentUser!.uid;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return loggedUser;
  }

  Future<bool> logout() async {
    String token = prefs.csrfToken ?? '';
    Uri _url = Uri.parse("$baseUrl/api/user/logout?_format=json&token=$token");

    Map<String, String> headers = authHeader;
    headers.addAll(sessionHeader);
    headers.addAll(logutHeader);
    headers.addAll(jsonHeader);
    try {
      var response = await http.post(
        _url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        cleanCookies();

        prefs.csrfToken = null;
        prefs.logoutToken = null;
        prefs.userId = null;

        return true;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {}

    return false;
  }

  Future<UserModel?> getUserData() async {
    String? userId = prefs.userId;
    UserModel? userinfo;
    try {
      Uri _url = Uri.parse("$baseUrl/api/user/$userId?_format=json");

      var response = await http.get(_url);

      if (response.statusCode == 200) {
        userinfo = UserModel.fromJson(response.body);
        prefs.userName = userinfo.userName;
        debugPrint(userinfo.toString());
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return userinfo;
  }
}
