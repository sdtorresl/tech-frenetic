import 'package:techfrenetic/app/modules/choose_avatar/choose_avatar_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/choose_avatar/choose_avatar_page.dart';

class ChooseAvatarModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ChooseAvatarController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const ChooseAvatarPage()),
  ];
}
