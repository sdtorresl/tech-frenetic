import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:techfrenetic/app/core/exceptions.dart';
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

      prefs.csrfToken = null;
      prefs.logoutToken = null;
      prefs.userId = null;
      prefs.sessionExpirationDate = DateTime.now();
      prefs.userId = null;
      prefs.userEmail = null;

      cleanCookies();

      if (response.statusCode == 200) {
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
        userinfo = UserModel.fromJson(response.body);
        prefs.userName = userinfo.userName;
        prefs.userEmail = userinfo.mail;
        prefs.userAvatar = userinfo.avatar;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return userinfo;
  }

  Future<UserModel?> getUser(String userId) async {
    UserModel? userinfo;
    try {
      Uri _url = Uri.parse("$baseUrl/api/user/$userId?_format=json");
      debugPrint("Getting user information with id $userId");
      debugPrint(_url.toString());

      var response = await http.get(
        _url,
      );

      if (response.statusCode == 200) {
        userinfo = UserModel.fromJson(response.body);
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
    bool tokenExpired = !DateTime.now().isBefore(prefs.sessionExpirationDate);
    return tokenExists && !tokenExpired;
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
        return true;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
        debugPrint('Request failed with status: ${response.body}.');
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

  Future<bool> updateInterests(List<CategoriesModel> interests) async {
    debugPrint("Updating interests for user $userId...");
    try {
      Uri _url = Uri.parse("$baseUrl/api/user/$userId?_format=json");

      Map<String, dynamic> body = {
        "field_interests": List<dynamic>.from(interests.map((x) => x.toMap())),
      };

      Map<String, String> headers = {};
      headers.addAll(jsonHeader);
      headers.addAll(authHeader);
      headers.addAll(sessionHeader);
      headers.addAll(headers);

      debugPrint(json.jsonEncode(body));
      var response = await http.patch(
        _url,
        body: json.jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
        debugPrint(response.reasonPhrase);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<bool> updateBiografy(String biografy) async {
    if (prefs.userId == null) {
      return false;
    }

    String userId = prefs.userId!;
    debugPrint("Updating biografy for user $userId...");
    try {
      Uri _url = Uri.parse("$baseUrl/api/user/$userId?_format=json");

      Map<String, dynamic> body = {
        "field_biography": [
          {"value": biografy}
        ],
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
        return true;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
        debugPrint(response.reasonPhrase);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<bool> recoverPassword(String email) async {
    Uri _url = Uri.parse("$baseUrl/api/user/lost-password?_format=json");
    debugPrint("Recovering password for user $email...");
    debugPrint(_url.toString());

    try {
      String body = json.jsonEncode({"lang": "en", "mail": email});
      var response = await http.post(
        _url,
        body: body,
        headers: jsonHeader,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {}

    return false;
  }

  Future<bool> requestChangePassToken(String email) async {
    Uri _url = Uri.parse("$baseUrl/api/user/lost-password?_format=json");
    debugPrint("Sending token to email $email...");
    debugPrint(_url.toString());

    Map<String, dynamic> body = {"mail": email};
    Map<String, String> headers = {};
    headers
      ..addAll(authHeader)
      ..addAll(jsonHeader)
      ..addAll(sessionHeader);

    try {
      var response = await http.post(
        _url,
        body: json.jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200) {
        debugPrint("Email was send successfully");
        return true;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return false;
  }

  Future<bool> updatePassword(String token, String newPassword) async {
    UserModel? loggedUser = await getLoggedUser();
    if (loggedUser != null) {
      Uri _url =
          Uri.parse("$baseUrl/api/user/lost-password-reset?_format=json");
      debugPrint("Updating password for user ${loggedUser.userName}...");
      debugPrint(_url.toString());

      Map<String, dynamic> body = {
        "name": loggedUser.userName,
        "temp_pass": token,
        "new_pass": newPassword
      };

      Map<String, String> headers = jsonHeader;

      try {
        var response = await http.post(
          _url,
          body: json.jsonEncode(body),
          headers: headers,
        );

        if (response.statusCode == 200) {
          debugPrint("Password changed successfully");
          return true;
        } else {
          debugPrint('Request failed with status: ${response.statusCode}.');
          debugPrint('Request failed with status: ${response.body}.');
          if (response.statusCode == 400) {
            throw TokenInvalidException();
          }
        }
      } on SocketException {
        debugPrint('No Internet connection 😑');
      } on FormatException {
        debugPrint("Bad response format 👎");
      }
    }

    return false;
  }
}
