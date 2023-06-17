import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:techfrenetic/app/modules/events/recent_events_store.dart';

part 'events_store.g.dart';

class EventsStore = _EventsStore with _$EventsStore;

enum StoreState { initial, loading, loaded }

abstract class _EventsStore with Store {
  @observable
  RecentEventsStore recentEventsStore = Modular.get();
}
