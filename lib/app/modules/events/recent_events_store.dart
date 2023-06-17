import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:techfrenetic/app/core/extensions.dart';
import 'package:techfrenetic/app/modules/events/events_store.dart';

import '../../models/events_model.dart';
import '../../providers/events_provider.dart';

part 'recent_events_store.g.dart';

class RecentEventsStore = _RecentEventsStore with _$RecentEventsStore;

abstract class _RecentEventsStore with Store {
  final _eventsProvider = Modular.get<EventsProvider>();

  @observable
  ObservableFuture<List<EventsModel>>? _recentEventsFuture;

  @observable
  ObservableList<EventsModel> recentEvents = ObservableList.of([]);

  @observable
  ObservableList<EventsModel> filteredRecentEvents = ObservableList.of([]);

  String? name;
  DateTime? date;
  String? category;

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController categoryEditingController = TextEditingController();
  TextEditingController dateEditingController = TextEditingController();

  _RecentEventsStore() {
    nameEditingController.addListener(_changeName);
    categoryEditingController.addListener(_changeCategory);
    dateEditingController.addListener(_changeDate);
  }

  void _changeName() {
    name = nameEditingController.text;
  }

  void _changeDate() {
    date = nameEditingController.text.toDateTime();
  }

  void _changeCategory() {
    category = nameEditingController.text;
  }

  @computed
  StoreState get state {
    if (_recentEventsFuture == null ||
        _recentEventsFuture?.status == FutureStatus.pending) {
      return StoreState.initial;
    }

    return _recentEventsFuture!.status == FutureStatus.pending
        ? StoreState.loading
        : StoreState.loaded;
  }

  @action
  Future fetchRecentEvents() async {
    _recentEventsFuture = ObservableFuture(_eventsProvider.getRecentEvents());
    recentEvents = ObservableList.of(await _recentEventsFuture!);
    return _recentEventsFuture;
  }

  @action
  search() async {
    filteredRecentEvents = ObservableList();

    if (name != null && name!.isNotEmpty) {
      filteredRecentEvents = ObservableList.of(recentEvents.where((element) =>
          element.eventName.toLowerCase().contains(name!.toLowerCase())));
    }
  }
}
