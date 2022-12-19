import 'package:techfrenetic/app/modules/sign_up/create_profile/confirm_number_page.dart';

import 'create_profile_controller.dart';
import 'create_profile_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CreateProfileModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CreateProfileController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const CreateProfilePage()),
    ChildRoute('/confirm_number',
        child: (_, args) => const ConfirmNumberPage()),
  ];
}
