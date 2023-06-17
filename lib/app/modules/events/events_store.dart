import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:techfrenetic/app/models/events_model.dart';
import 'package:techfrenetic/app/providers/events_provider.dart';

part 'events_store.g.dart';

class EventsStore = _EventsStore with _$EventsStore;

abstract class _EventsStore with Store {
  final _eventsProvider = Modular.get<EventsProvider>();

  @observable
  ObservableFuture<List<EventsModel>>? recentEventsFuture;

  @action
  Future fetchRecentEvents() =>
      recentEventsFuture = ObservableFuture(_eventsProvider.getRecentEvents());

  void loadEvents() {
    fetchRecentEvents();
  }
}
