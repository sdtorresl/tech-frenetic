import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/events/events_page.dart';
import 'package:techfrenetic/app/modules/events/events_store.dart';
import 'package:techfrenetic/app/modules/events/recent_events_store.dart';
import 'package:techfrenetic/app/providers/events_provider.dart';

class EventsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => EventsProvider()),
    Bind.lazySingleton((i) => EventsStore()),
    Bind.lazySingleton((i) => RecentEventsStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => const EventsPage(),
    ),
    /* ChildRoute(
      '/:id',
      child: (_, args) => GroupPage(int.parse(args.params['id'])),
    ), */
  ];
}
