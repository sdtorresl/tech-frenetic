import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:techfrenetic/app/core/extensions/datetime_utils.dart';
import 'package:techfrenetic/app/modules/events/events_store.dart';

import '../../core/utils/selectable_item.dart';
import '../../models/dtos/event_filter_dto.dart';
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
  @observable
  SelectableItem? category;

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController categoryEditingController = TextEditingController();
  TextEditingController dateEditingController = TextEditingController();

  _RecentEventsStore() {
    nameEditingController.addListener(_changeName);
  }

  void _changeName() {
    name = nameEditingController.text;
  }

  @action
  void changeDate(DateTime? dateTime) {
    if (dateTime != null) {
      dateEditingController.text = dateTime.toDateString();
      date = dateTime;
    }
  }

  void changeCategory(SelectableItemI? newCategory) {
    category = newCategory as SelectableItem;
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
    var filter =
        EventFilterDto(name: name, startDate: date, category: category?.label);
    _recentEventsFuture =
        ObservableFuture(_eventsProvider.getRecentEvents(filter: filter));
    recentEvents = ObservableList.of(await _recentEventsFuture!);
  }
}
