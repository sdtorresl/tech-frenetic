import 'package:shared_preferences/shared_preferences.dart';

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

  set userId(String? currentId) => _prefs.setString('current_user', currentId!);

  String? get userId => _prefs.getString('current_user');

  set csrfToken(String? csrfToken) =>
      _prefs.setString('csrf_token', csrfToken!);

  String? get csrfToken => _prefs.getString('csrf_token');

  set cookies(String? cookies) => _prefs.setString('cookies', cookies!);

  String? get cookies => _prefs.getString('cookies');

  set logoutToken(String? logoutToken) =>
      _prefs.setString('logout_token', logoutToken!);

  String? get logoutToken => _prefs.getString('logout_token');

  set userName(String? userName) => _prefs.setString('name', userName!);

  String? get userName => _prefs.getString('name');

  set userEmail(String? userEmail) => _prefs.setString('mail', userEmail!);

  String? get userEmail => _prefs.getString('mail');

  set sessionExpirationDate(DateTime expirationDate) =>
      _prefs.setString('expiration_date', expirationDate.toIso8601String());

  DateTime get sessionExpirationDate =>
      DateTime.tryParse(_prefs.getString('expiration_date') ?? '') ??
      DateTime.now();
}
