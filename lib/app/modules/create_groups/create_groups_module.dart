import 'package:techfrenetic/app/modules/create_groups/create_groups_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/create_groups/create_groups_page.dart';
import 'package:techfrenetic/app/providers/group_providers.dart';

class CreateGroupsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CreateGroupsController()),
    Bind.lazySingleton((i) => GroupsProvider())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const CreateGroupsPage()),
  ];
}
