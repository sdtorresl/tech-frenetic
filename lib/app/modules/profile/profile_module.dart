import 'package:techfrenetic/app/modules/my_account/my_account_module.dart';
import 'package:techfrenetic/app/modules/my_account/my_account_page.dart';
//import 'package:techfrenetic/app/modules/profile/profile_controller.dart';
import 'package:techfrenetic/app/modules/profile/profile_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SingUpController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const ProfilePage(
              selectedPage: 0,
            ),
        children: [
          ModuleRoute(
            '/my_account',
            module: MyAccountModule(),
          ),
        ]),
  ];
}

class SingUpController {}
