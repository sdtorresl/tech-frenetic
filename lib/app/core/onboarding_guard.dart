import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/core/user_preferences.dart';

class OnboardingGuard extends RouteGuard {
  OnboardingGuard() : super(redirectTo: '/about_us');

  @override
  bool canActivate(String path, ModularRoute route) {
    UserPreferences userPreferences = UserPreferences();
    return !userPreferences.newUser;
  }
}
