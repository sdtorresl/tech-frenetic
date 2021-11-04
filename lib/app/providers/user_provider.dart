import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:techfrenetic/app/models/session_model.dart';
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:techfrenetic/app/preferences/user_preferences.dart';

class UserProvider {
  final _prefs = UserPreferences();
  final String _baseUrl = GlobalConfiguration().getValue("api_url");
  SessionModel? loggedUser;
  Future<SessionModel?> login(String email, String password) async {
    SessionModel? loggedUser;

    try {
      Uri _url = Uri.parse("$_baseUrl/api/user/login?_format=json");

      String body = json.encode({'name': email, 'pass': password});
      SessionModel? loggedUser;

      var response = await http.post(
        _url,
        body: body,
        headers: <String, String>{'content-type': 'application/json'},
      );

      if (response.statusCode == 200) {
        loggedUser = SessionModel.fromJson(response.body);
        debugPrint(loggedUser.toString());
        _prefs.csrfToken = loggedUser.csrfToken;
        _prefs.logoutToken = loggedUser.logoutToken;
        _prefs.userId = loggedUser.currentUser!.uid;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return loggedUser;
  }

  Future<UserModel> getUserData() async {
    UserModel userinfo = UserModel(
        uid: "",
        uuid: "",
        langcode: "",
        userName: "",
        created: DateTime.now(),
        changed: DateTime.now(),
        biography: "",
        birthdate: DateTime.now(),
        cellphone: "",
        company: "",
        dateSavePassword: DateTime.now(),
        name: "",
        userLocation: "",
        userProfession: "",
        userType: "",
        useAvatar: true,
        userPicture: "");
    String userId = _prefs.userId!;

    try {
      Uri _url = Uri.parse("$_baseUrl/api/en/user/$userId?_format=json");

      var response = await http.get(_url);

      if (response.statusCode == 200) {
        userinfo = UserModel.fromJson(response.body);
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
