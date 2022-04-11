import 'package:techfrenetic/app/modules/login/login_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/notifications/notifications_page.dart';

class NotificationsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const NotificationsPage()),
  ];
}
