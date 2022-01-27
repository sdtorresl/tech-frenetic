import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/search/search_controller.dart';
import 'package:techfrenetic/app/modules/search/search_page.dart';

class SearchModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SearchController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const SearchPage(),
    )
  ];
}
