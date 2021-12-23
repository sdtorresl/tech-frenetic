import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techfrenetic/app/providers/tf_provider.dart';

class RegistrationProvider extends TechFreneticProvider {
  Future<String?> signUp(String userName, String email, String password,
      String name, String? userType) async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/user/register?_format=hal_json");

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
      Map<String, String> headers = {
        'X-CSRF-Token': '',
      };
      headers.addAll(basicAuth);
      headers.addAll(jsonHeader);

      headers.addAll(headers);
      var response = await http.post(
        _url,
        body: json.encode(body),
        headers: headers,
      );
      debugPrint(response.statusCode.toString());

      if (response.statusCode == 422) {
        debugPrint(response.body);
        if (response.body.contains(userName)) {
          return userName;
        } else if (response.body.contains(email)) {
          return email;
        } else {
          return response.body;
        }
      }
      if (response.statusCode == 200) {
        debugPrint(response.body);
        return true.toString();
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<bool?> createProfile(String companyName, String profession,
      String country, String description) async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/user/$userId?_format=hal_json");

      Map<String, dynamic> body = {
        "field_biography": {"value": description},
        "field_company": {"value": companyName},
        "field_user_location": {"value": country},
        "field_user_profession": {"value": profession}
      };

      Map<String, String> headers = {};
      headers.addAll(authHeader);
      headers.addAll(jsonHeader);
      headers.addAll(sessionHeader);
      headers.addAll(headers);

      var response = await http.patch(
        _url,
        body: json.encode(body),
        headers: headers,
      );
      debugPrint(response.statusCode.toString());

      if (response.statusCode == 200) {
        debugPrint(response.body);
        return true;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<bool?> selectAvatar(bool useAvatar, String userAvatar) async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/user/$userId?_format=hal_json");

      Map<String, dynamic> body = {
        "field_use_avatar": [
          {"value": useAvatar}
        ],
        "field_user_avatar": [
          {"value": userAvatar}
        ],
      };

      Map<String, String> headers = {};
      headers.addAll(authHeader);
      headers.addAll(jsonHeader);
      headers.addAll(sessionHeader);
      headers.addAll(headers);

      var response = await http.patch(
        _url,
        body: json.encode(body),
        headers: headers,
      );
      debugPrint(response.statusCode.toString());

      if (response.statusCode == 200) {
        debugPrint(response.body);
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
