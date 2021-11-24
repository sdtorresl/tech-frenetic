import 'package:global_configuration/global_configuration.dart';
import 'package:techfrenetic/app/preferences/user_preferences.dart';

class TechFreneticProvider {
  final String baseUrl = GlobalConfiguration().getValue("api_url");
  final prefs = UserPreferences();

  Map<String, String> get authHeader => {'X-CSRF-Token': prefs.csrfToken ?? ''};

  Map<String, String> get logutHeader => {'token': prefs.logoutToken ?? ''};
}
