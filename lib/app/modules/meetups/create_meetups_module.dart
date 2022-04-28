import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/meetups/create_meetups_page.dart';
import 'package:techfrenetic/app/modules/meetups/meetups_controller.dart';

class CreateMeetupsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MeetupsController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const CreateMeetupsPage()),
  ];
}
