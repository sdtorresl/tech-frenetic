import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:techfrenetic/app/preferences/user_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TechFreneticProvider {
  final String baseUrl = GlobalConfiguration().getValue("api_url");
  final prefs = UserPreferences();

  String authentication() {
    String username = 'kerlynhans@gmail.com';
    String password = 'aii28XGaHLxaSGR';
    String basicAuthValue =
        'Basic' + base64Encode(utf8.encode('$username:$password'));
    return basicAuthValue;
  }

  Map<String, String> get basicAuth => {'Authorization': authentication()};

  Map<String, String> get authHeader => {'X-CSRF-Token': prefs.csrfToken ?? ''};

  Map<String, String> get sessionHeader => {'Cookie': prefs.cookies ?? ''};

  Map<String, String> get logutHeader => {'token': prefs.logoutToken ?? ''};

  Map<String, String> get jsonHeader => {'content-type': 'application/json'};

  String get locale => Intl.getCurrentLocale().startsWith("es") ? "es" : "en";

  String? get userId => prefs.userId;

  void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    debugPrint("Cookie: $rawCookie");
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      prefs.cookies = (index == -1) ? rawCookie : rawCookie.substring(0, index);
      debugPrint("Cookie: ${prefs.cookies}");
    }
  }

  void cleanCookies() {
    prefs.cookies = '';
  }
}
