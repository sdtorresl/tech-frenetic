import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/community/community_page.dart';
import 'package:techfrenetic/app/widgets/article_widget.dart';

class CommunityModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const CommunityPage(),
      children: [
        ChildRoute('/article',
            child: (context, args) => ArticleWidget(article: args.data))
      ],
    )
  ];
}
