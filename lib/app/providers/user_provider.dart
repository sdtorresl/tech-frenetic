import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:techfrenetic/app/preferences/user_preferences.dart';

class UserProvider {
  final _prefs = UserPreferences();
  final String _baseUrl = GlobalConfiguration().getValue("api_url");

  Future<SessionModel?> login(String email, String password) async {
    SessionModel? loggedUser;

    try {
      Uri _url = Uri.parse("$_baseUrl/api/user/login?_format=json");

      String body = json.encode({'name': email, 'pass': password});

      var response = await http.post(
        _url,
        body: body,
        headers: <String, String>{'content-type': 'application/json'},
      );

      if (response.statusCode == 200) {
        loggedUser = SessionModel.fromJson(response.body);
        debugPrint(loggedUser.toString());
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return loggedUser;
  }

  // Future<List<UserModel>> login(List<UserModel> userinfo,) async {
  //   final String _baseUrl = GlobalConfiguration().getValue("api_url");
  //   List<UserModel> userinfo = [];

  //   try {
  //     Uri _url = Uri.parse(_baseUrl + "/api/en/user/" + userinfo + "?_format=json");

  //     var response = await http.get(_url);

  //     if (response.statusCode == 200) {
  //       List<dynamic> jsonResponse = json.decode(response.body)["current_user"];
  //       for (var item in jsonResponse) {
  //         UserModel userid = UserModel.fromMap(item);
  //         userinfo.add(userid);
  //       }
  //     } else {
  //       print('Request failed with status: ${response.statusCode}.');
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   return userinfo;
  // }
}
