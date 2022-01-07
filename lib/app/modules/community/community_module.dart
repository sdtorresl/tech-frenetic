import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/community/community_controller.dart';
import 'package:techfrenetic/app/modules/community/community_page.dart';
import 'package:techfrenetic/app/modules/groups/groups_module.dart';

class CommunityModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CommunityController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const CommunityPage(),
    ),
  ];
}
