import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/login/');

  @override
  bool canActivate(String path, ModularRoute router) {
    UserProvider userProvider = UserProvider();
    return userProvider.isLogged();
  }
}
