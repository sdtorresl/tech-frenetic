import 'package:techfrenetic/app/modules/create_meetups/create_metups_controller.dart';
import 'package:techfrenetic/app/modules/create_meetups/create_metups_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CreateMeetupsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CreateMeetupsController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const CreateMeetupsPage()),
  ];
}
