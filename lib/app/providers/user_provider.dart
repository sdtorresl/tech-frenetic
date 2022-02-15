import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:techfrenetic/app/models/categories_model.dart';
import 'package:techfrenetic/app/models/profile_model.dart';
import 'package:techfrenetic/app/models/session_model.dart';
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';
import 'dart:convert' as json;

class UserProvider extends TechFreneticProvider {
  SessionModel? loggedUser;

  Future<SessionModel?> login(String email, String password) async {
    SessionModel? loggedUser;

    try {
      Uri _url = Uri.parse("$baseUrl/api/user/login?_format=json");

      String body = json.jsonEncode({'name': email, 'pass': password});

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

  Future<UserModel?> getLoggedUser() async {
    String? userId = prefs.userId;
    UserModel? userinfo;
    try {
      Uri _url = Uri.parse("$baseUrl/api/user/$userId?_format=json");

      Map<String, String> headers = {};

      headers.addAll(sessionHeader);
      headers.addAll(headers);

      var response = await http.get(
        _url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        debugPrint(response.body);
        userinfo = UserModel.fromJson(response.body);
        prefs.userName = userinfo.userName;
        prefs.userEmail = userinfo.mail;
        prefs.userAvatar = userinfo.fieldUserAvatar;
        debugPrint(userinfo.toString());
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return userinfo;
  }

  Future<UserModel?> getUser(userId) async {
    UserModel? userinfo;
    try {
      Uri _url = Uri.parse("$baseUrl/api/user/$userId?_format=json");

      var response = await http.get(
        _url,
      );

      if (response.statusCode == 200) {
        debugPrint(response.body);
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

  Future<ProfileModel?> getProfile(String userId) async {
    ProfileModel userinfo = ProfileModel.empty();

    try {
      Uri _url = Uri.parse(
          "$baseUrl/api/$locale/v1/full-profile?_format=json&id=$userId");

      var response = await http.get(_url);

      if (response.statusCode == 200) {
        List<dynamic> profiles = json.jsonDecode(response.body);

        if (profiles.isNotEmpty) {
          userinfo = ProfileModel.fromJson(profiles[0]);
          if (!userinfo.useAvatar) {
            userinfo.picture = baseUrl + userinfo.picture;
          }
        }
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return userinfo;
  }

  bool isLogged() {
    bool tokenExists = prefs.csrfToken?.isNotEmpty ?? false;
    bool isNotExpired = DateTime.now().isBefore(prefs.sessionExpirationDate);
    return tokenExists && isNotExpired;
  }

  Future<bool> userUpdate(DateTime birthdate, String cellphone, String country,
      String email) async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/user/$userId?_format=hal_json");

      Map<String, dynamic> body = {
        "field_birthdate": {"value": DateFormat("yy-MM-dd").format(birthdate)},
        "field_cellphone": {"value": cellphone},
        "field_user_location": {"value": country},
        "mail": {"value": email}
      };

      Map<String, String> headers = {};
      headers.addAll(jsonHeader);
      headers.addAll(authHeader);
      headers.addAll(sessionHeader);
      headers.addAll(headers);

      var response = await http.patch(
        _url,
        body: json.jsonEncode(body),
        headers: headers,
      );

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

  Future<bool> updateCertifications(List<String> certifications) async {
    debugPrint("Updating certifications for user $userId...");
    try {
      Uri _url = Uri.parse("$baseUrl/api/user/$userId?_format=hal_json");

      Map<String, dynamic> body = {"field_certifications": certifications};

      Map<String, String> headers = {};
      headers.addAll(jsonHeader);
      headers.addAll(authHeader);
      headers.addAll(sessionHeader);
      headers.addAll(headers);

      var response = await http.patch(
        _url,
        body: json.jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  updateInterests(List<CategoriesModel> interests) async {
    debugPrint("Updating interests for user $userId...");
    try {
      Uri _url = Uri.parse("$baseUrl/api/user/$userId?_format=json");

      Map<String, dynamic> body = {
        "field_interests": [
          {"target_id": 1}
        ]
      };
      debugPrint("Body: " + body.toString());
      debugPrint("Body: " + json.jsonEncode(body.toString()));

      Map<String, String> headers = {};
      headers.addAll(jsonHeader);
      headers.addAll(authHeader);
      headers.addAll(sessionHeader);
      headers.addAll(headers);

      debugPrint(headers.toString());

      var response = await http.patch(
        _url,
        body: json.jsonEncode(body),
        headers: headers,
      );

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
