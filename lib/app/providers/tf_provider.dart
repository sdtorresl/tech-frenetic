import 'package:global_configuration/global_configuration.dart';
import 'package:techfrenetic/app/preferences/user_preferences.dart';

class TechFreneticProvider {
  final String baseUrl = GlobalConfiguration().getValue("api_url");
  final prefs = UserPreferences();

  authHeader() {
    return {'X-CSRF-Token': prefs.csrfToken};
  }

  logoutHeader() {
    return {'token': prefs.logoutToken};
  }
}
