import 'package:techfrenetic/app/modules/create_profile/create_profile_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/create_profile/create_profile_page.dart';

class CreateProfileModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CreateProfileController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const CreateProfilePage()),
  ];
}
