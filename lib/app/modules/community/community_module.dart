import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/community/community_page.dart';
import 'package:techfrenetic/app/modules/community/community_store.dart';
import 'package:techfrenetic/app/providers/advertisement_provider.dart';

class CommunityModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => CommunityStore()),
    Bind.lazySingleton((i) => AdvertisementProvider()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const CommunityPage(),
    ),
  ];
}
