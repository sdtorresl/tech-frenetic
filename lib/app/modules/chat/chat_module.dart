import 'package:techfrenetic/app/modules/chat/chat_page.dart';
import 'package:techfrenetic/app/modules/chat/chat_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/chat/messaging_page.dart';
import 'package:techfrenetic/app/modules/chat/messaging_store.dart';
import 'package:techfrenetic/app/modules/home/home_store.dart';

class ChatModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => ChatStore()),
    Bind.lazySingleton((i) => HomeStore()),
    Bind.factory((i) => MessagingStore()),
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
        entity: args.data,
      ),
    ),
  ];
}
