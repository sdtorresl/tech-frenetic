import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:techfrenetic/app/core/extensions/datetime_utils.dart';
import 'package:techfrenetic/app/models/categories_model.dart';
import 'package:techfrenetic/app/models/dtos/event_filter_dto.dart';
import 'package:techfrenetic/app/modules/events/events_store.dart';

import '../../core/utils/selectable_item.dart';
import '../../models/events_model.dart';
import '../../providers/events_provider.dart';

part 'upcomming_events_store.g.dart';

class UpcommingEventsStore = _UpcommingEventsStore with _$UpcommingEventsStore;

abstract class _UpcommingEventsStore with Store {
  final _eventsProvider = Modular.get<EventsProvider>();

  @observable
  ObservableFuture<List<EventsModel>>? _upcommingEventsFuture;

  @observable
  ObservableList<EventsModel> upcommingEvents = ObservableList.of([]);

  String? name;
  DateTime? date;

  @observable
  SelectableItem? category;

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController dateEditingController = TextEditingController();

  _UpcommingEventsStore() {
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
  StoreState get upcommingEventsState {
    if (_upcommingEventsFuture == null) {
      return StoreState.initial;
    }

    return _upcommingEventsFuture!.status == FutureStatus.pending
        ? StoreState.loading
        : StoreState.loaded;
  }

  @action
  Future fetchUpcommingEvents() async {
    _upcommingEventsFuture =
        ObservableFuture(_eventsProvider.getRecentEvents());
    upcommingEvents = ObservableList.of(await _upcommingEventsFuture!);
    return _upcommingEventsFuture;
  }

  @action
  search() async {
    var filter =
        EventFilterDto(name: name, startDate: date, category: category?.label);
    _upcommingEventsFuture =
        ObservableFuture(_eventsProvider.getRecentEvents(filter: filter));
    upcommingEvents = ObservableList.of(await _upcommingEventsFuture!);
  }
}
