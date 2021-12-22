import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/preferences/user_preferences.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/login/');

  @override
  bool canActivate(String path, ModularRoute router) {
    UserPreferences _prefs = UserPreferences();
    return _prefs.csrfToken?.isNotEmpty ?? false;
  }
}
