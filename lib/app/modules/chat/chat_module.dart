import 'package:techfrenetic/app/modules/chat/chat_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/home/home_store.dart';
import 'package:techfrenetic/app/modules/not_implemented/not_implemented_page.dart';

class ChatModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ChatStore()),
    Bind.lazySingleton((i) => HomeStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const NotImplementedPage(),
    ),
  ];
}
