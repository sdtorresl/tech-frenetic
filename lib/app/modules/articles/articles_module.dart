import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/articles/articles_controller.dart';
import 'package:techfrenetic/app/modules/articles/articles_page.dart';
import 'package:techfrenetic/app/providers/articles_provider.dart';

class ArticlesModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ArticlesController()),
    Bind.lazySingleton((i) => ArticlesProvider()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => ArticlesPage(
        article: args.data,
      ),
    ),
  ];
}
