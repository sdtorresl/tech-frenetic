import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:techfrenetic/app/core/user_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TechFreneticProvider {
  final String baseUrl = GlobalConfiguration().getValue("api_url");
  final prefs = UserPreferences();

  Map<String, String> get authHeader => {'X-CSRF-Token': prefs.csrfToken ?? ''};

  Map<String, String> get sessionHeader => {'Cookie': prefs.cookies ?? ''};

  Map<String, String> get logutHeader => {'token': prefs.logoutToken ?? ''};

  Map<String, String> get jsonHeader => {'Content-Type': 'application/json'};

  String get locale => Intl.getCurrentLocale().startsWith("es") ? "es" : "en";

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
    prefs.sessionExpirationDate = DateTime.now();
  }
}
