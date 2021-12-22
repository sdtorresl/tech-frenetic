import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techfrenetic/app/models/session_model.dart';
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';

class RegistrationProvider extends TechFreneticProvider {
  Future<UserModel?> signUp(String userName, String email, String password,
      String name, String? userType) async {
    UserModel? loggedUser;

    try {
      Uri _url = Uri.parse(
          "https://dev-techfrenetic.us.seedcloud.co/$locale/api/user/register?_format=hal_json");

      Map<String, dynamic> body = {
        "name": [
          {"value": userName}
        ],
        "mail": [
          {"value": email}
        ],
        "pass": [
          {"value": password}
        ],
        "field_name": [
          {"value": name}
        ],
        "field_user_type": [
          {"value": userType}
        ]
      };
      Map<String, String> headers = {};
      // headers.addAll(authHeader);
      // headers['Content-Type'] = 'application/json';
      // headers.addAll(sessionHeader);

      var response = await http.post(
        _url,
        body: json.encode(body),
        headers: headers,
      );
      if (response.statusCode == 422) {
        debugPrint(response.statusCode.toString());
        return loggedUser;
      }
      if (response.statusCode == 200) {
        debugPrint(response.statusCode.toString());
        loggedUser = UserModel.fromJson(response.body);
        return loggedUser;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
