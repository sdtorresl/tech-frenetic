import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/articles/articles_controller.dart';
import 'package:techfrenetic/app/modules/users_profiles/users_profiles_page.dart';

class UsersProfilesModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ArticlesController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => UsersProfilesPage(
        article: args.data,
      ),
    ),
  ];
}
