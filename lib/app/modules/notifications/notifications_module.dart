import 'package:techfrenetic/app/modules/login/login_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/notifications/notifications_page.dart';
import 'package:techfrenetic/app/modules/notifications/notifications_store.dart';

class NotificationsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginController()),
    Bind.lazySingleton((i) => NotificationsStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const NotificationsPage()),
  ];
}
