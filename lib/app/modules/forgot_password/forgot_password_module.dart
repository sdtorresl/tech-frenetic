import 'package:techfrenetic/app/modules/forgot_password/forgot_password_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/forgot_password/forgot_password_page.dart';

class ForgotPasswordModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ForgotPasswordController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const ForgotPasswordPage()),
  ];
}
