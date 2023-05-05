import 'package:techfrenetic/app/modules/chat/chat_page.dart';
import 'package:techfrenetic/app/modules/chat/chat_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/chat/chat_group_page.dart';
import 'package:techfrenetic/app/modules/chat/messaging_page.dart';
import 'package:techfrenetic/app/modules/home/home_store.dart';

class ChatModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => ChatStore()),
    Bind.lazySingleton((i) => HomeStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const ChatPage(),
    ),
    ChildRoute(
      '/message',
      child: (_, args) => MessagingPage(
        user: args.data,
      ),
    ),
    ChildRoute(
      '/group',
      child: (_, args) => ChatGroupPage(
        group: args.data,
      ),
    ),
  ];
}
