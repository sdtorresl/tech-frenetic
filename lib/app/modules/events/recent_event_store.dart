import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../models/events_model.dart';
import '../../providers/events_provider.dart';

part 'recent_event_store.g.dart';

class RecentEventStore = _RecentEventStore with _$RecentEventStore;

enum RecentEventStoreState { initial, loading, loaded, error }

abstract class _RecentEventStore with Store {
  final _eventsProvider = Modular.get<EventsProvider>();

  @observable
  ObservableFuture<EventsModel?>? _recentEventFuture;

  @observable
  EventsModel? event;

  _RecentEventStore() {
    fetchRecentEvents();
  }

  @computed
  RecentEventStoreState get state {
    if (_recentEventFuture == null ||
        _recentEventFuture?.status == FutureStatus.pending) {
      return RecentEventStoreState.initial;
    }

    return _recentEventFuture!.status == FutureStatus.pending
        ? RecentEventStoreState.loading
        : RecentEventStoreState.loaded;
  }

  @action
  Future fetchRecentEvents() async {
    _recentEventFuture = ObservableFuture(_eventsProvider.getRecentEvent());
    event = await _recentEventFuture!;
    return _recentEventFuture;
  }
}
