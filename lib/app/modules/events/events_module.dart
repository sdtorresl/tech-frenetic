import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/events/event_page.dart';
import 'package:techfrenetic/app/modules/events/event_store.dart';
import 'package:techfrenetic/app/modules/events/events_page.dart';
import 'package:techfrenetic/app/modules/events/events_store.dart';
import 'package:techfrenetic/app/modules/events/recent_events_store.dart';
import 'package:techfrenetic/app/modules/events/upcomming_events_store.dart';
import 'package:techfrenetic/app/providers/categories_provider.dart';
import 'package:techfrenetic/app/providers/events_provider.dart';

import 'recent_event_store.dart';

class EventsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CategoriesProvider()),
    Bind.lazySingleton((i) => EventsProvider()),
    Bind.lazySingleton((i) => EventsStore()),
    Bind.factory((i) => EventStore()),
    Bind.lazySingleton((i) => RecentEventStore()),
    Bind.lazySingleton((i) => RecentEventsStore()),
    Bind.lazySingleton((i) => UpcommingEventsStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => const EventsPage(),
    ),
    ChildRoute(
      '/:slug',
      child: (_, args) => EventPage(slug: args.params['slug']),
    ),
  ];
}
