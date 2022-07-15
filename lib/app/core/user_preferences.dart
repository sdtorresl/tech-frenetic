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

  set userId(String? currentId) =>
      _prefs.setString('current_user', currentId ?? '');

  String? get userId => _prefs.getString('current_user');

  set csrfToken(String? csrfToken) =>
      _prefs.setString('csrf_token', csrfToken ?? '');

  String? get csrfToken => _prefs.getString('csrf_token');

  set cookies(String? cookies) => _prefs.setString('cookies', cookies!);

  String? get cookies => _prefs.getString('cookies');

  set logoutToken(String? logoutToken) =>
      _prefs.setString('logout_token', logoutToken ?? '');

  String? get logoutToken => _prefs.getString('logout_token');

  set userName(String? userName) => _prefs.setString('name', userName!);

  String? get userName => _prefs.getString('name');

  set userEmail(String? userEmail) => _prefs.setString('mail', userEmail ?? '');

  String? get userEmail => _prefs.getString('mail');

  set userPhone(String? userPhone) => _prefs.setString('phone', userPhone!);

  String? get userPhone => _prefs.getString('phone');

  set userCountry(String? userCountry) =>
      _prefs.setString('country', userCountry!);

  String? get userCountry => _prefs.getString('country');

  set userBirthdate(DateTime? userBirthdate) =>
      _prefs.setString('birthday', userBirthdate!.toString());

  DateTime? get userBirthdate =>
      DateTime.tryParse(_prefs.getString('birthday') ?? '');

  set userAvatar(String? userAvatar) =>
      _prefs.setString('field_user_Avatar', userAvatar!);

  String get userAvatar => _prefs.getString('field_user_Avatar') ?? 'avatar-01';

  set sessionExpirationDate(DateTime expirationDate) =>
      _prefs.setString('expiration_date', expirationDate.toIso8601String());

  DateTime get sessionExpirationDate =>
      DateTime.tryParse(_prefs.getString('expiration_date') ?? '') ??
      DateTime.now();

  set newUser(bool newUser) => _prefs.setBool('new_user', newUser);

  bool get newUser => _prefs.getBool('new_user') ?? true;
}
