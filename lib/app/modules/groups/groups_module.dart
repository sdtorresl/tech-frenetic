import 'package:techfrenetic/app/modules/create_groups/create_groups_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/groups/groups_page.dart';

import 'group_controller.dart';
import 'group_page.dart';

class GroupsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CreateGroupsController()),
    Bind.lazySingleton((i) => GroupController())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => const GroupsPage(),
    ),
    ChildRoute(
      '/:id',
      child: (_, args) => GroupPage(int.parse(args.params['id'])),
    ),
  ];
}
