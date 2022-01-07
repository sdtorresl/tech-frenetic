import 'package:techfrenetic/app/modules/my_account/my_account_controller.dart';
import 'package:techfrenetic/app/modules/my_account/my_account_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MyAccountModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MyAccountController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const MyAccountPage()),
  ];
}
