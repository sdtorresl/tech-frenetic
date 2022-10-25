import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:techfrenetic/app/core/user_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TechFreneticProvider {
  final String baseUrl = GlobalConfiguration().getValue("api_url");
  final String cloudflareUrl = GlobalConfiguration().getValue("cloudflare_url");
  final String cloudflareAccount =
      GlobalConfiguration().getValue("cloudflare_account");
  final String cloudflareEmail =
      GlobalConfiguration().getValue("cloudflare_email");
  final String cloudflareKey = GlobalConfiguration().getValue("cloudflare_key");
  final prefs = UserPreferences();

  String authentication() {
    String username = 'kerlynhans@gmail.com';
    String password = 'aii28XGaHLxaSGR';
    String basicAuthValue =
        'Basic' + base64Encode(utf8.encode('$username:$password'));
    return basicAuthValue;
  }

  Map<String, String> get basicAuth => {'Authorization': authentication()};

  Map<String, String> get cloudflareAuth =>
      {'X-Auth-Key': cloudflareKey, 'X-Auth-Email': cloudflareEmail};

  Map<String, String> get authHeader => {'X-CSRF-Token': prefs.csrfToken ?? ''};

  Map<String, String> get sessionHeader => {'Cookie': prefs.cookies ?? ''};

  Map<String, String> get jsonHeader => {'Content-Type': 'application/json'};

  Map<String, String> get halHeader => {'Content-Type': 'application/hal+json'};

  String get locale => Intl.getCurrentLocale().startsWith("es") ? "es" : "en";

  String? get userId => prefs.userId;

  void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    debugPrint("Cookie: $rawCookie");
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      prefs.cookies = (index == -1) ? rawCookie : rawCookie.substring(0, index);
      debugPrint("Cookie: ${prefs.cookies}");

      try {
        String expireDateCookie = rawCookie
            .split(';')
            .firstWhere((s) => s.trim().toLowerCase().startsWith('expire'));
        String expireDateText = expireDateCookie.split('=').last;
        DateTime expirationDate =
            DateFormat('EEE, dd-MMM-yyyy hh:mm:ss zzz').parse(expireDateText);
        prefs.sessionExpirationDate = expirationDate;
      } catch (e) {
        prefs.sessionExpirationDate =
            DateTime.now().add(const Duration(days: 1));
      }
    }
  }

  void cleanCookies() {
    prefs.cookies = '';
    prefs.csrfToken = null;
    prefs.logoutToken = null;
    prefs.sessionExpirationDate = DateTime.now();
    prefs.userAvatar = null;
    prefs.userEmail = null;
    prefs.userId = null;
    prefs.userId = null;
    prefs.userName = null;
  }
}
