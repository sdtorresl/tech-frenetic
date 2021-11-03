import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:techfrenetic/app/models/user_model.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._internal();
  late SharedPreferences _prefs;

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  set currentUser(String? currentUser) =>
      _prefs.setString('current_user', jsonEncode(currentUser));

  String? get currentUser => _prefs.getString('current_user');

  set csrfToken(String? csrfToken) =>
      _prefs.setString('csrf_token', csrfToken!);

  String? get csrfToken => _prefs.getString('csrf_oken');

  set logoutToken(String? logoutToken) =>
      _prefs.setString('logout_token', logoutToken!);

  String? get logoutToken => _prefs.getString('logout_token');
}
