import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../models/detailed_event_model.dart';
import '../../providers/events_provider.dart';

part 'event_store.g.dart';

class EventStore = _EventStore with _$EventStore;

enum StoreState { initial, loading, loaded, error }

abstract class _EventStore with Store {
  @observable
  DetailedEventModel? event;

  @observable
  ObservableFuture<DetailedEventModel?>? _eventFuture;

  final _eventsProvider = Modular.get<EventsProvider>();

  @computed
  StoreState get state {
    if (_eventFuture == null || _eventFuture?.status == FutureStatus.rejected) {
      return StoreState.initial;
    }

    return _eventFuture!.status == FutureStatus.pending
        ? StoreState.loading
        : StoreState.loaded;
  }

  @action
  Future fetchEvent(String slug) async {
    _eventFuture = ObservableFuture(_eventsProvider.getEvent(slug));
    event = await _eventFuture;
    return _eventFuture;
  }
}
