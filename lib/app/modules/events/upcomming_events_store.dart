import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:techfrenetic/app/core/extensions/datetime_utils.dart';
import 'package:techfrenetic/app/models/categories_model.dart';
import 'package:techfrenetic/app/modules/events/events_store.dart';
import 'package:techfrenetic/app/providers/categories_provider.dart';

import '../../core/utils/selectable_item.dart';
import '../../models/events_model.dart';
import '../../providers/events_provider.dart';

part 'upcomming_events_store.g.dart';

class UpcommingEventsStore = _UpcommingEventsStore with _$UpcommingEventsStore;

abstract class _UpcommingEventsStore with Store {
  final _eventsProvider = Modular.get<EventsProvider>();
  final _categoriesProvider = Modular.get<CategoriesProvider>();

  @observable
  ObservableFuture<List<EventsModel>>? _upcommingEventsFuture;

  @observable
  ObservableFuture<List<CategoriesModel>>? _categoriesFuture;

  @observable
  ObservableList<CategoriesModel> categories = ObservableList.of([]);

  @observable
  ObservableList<EventsModel> upcommingEvents = ObservableList.of([]);

  @observable
  ObservableList<EventsModel> filteredRecentEvents = ObservableList.of([]);

  String? name;
  DateTime? date;

  @observable
  SelectableItem? category;

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController dateEditingController = TextEditingController();

  _UpcommingEventsStore() {
    nameEditingController.addListener(_changeName);
    fetchCategories();
  }

  @computed
  List<SelectableItem> get selectableCategories => categories
      .map(
        (cat) => SelectableItem(label: cat.category, value: cat.id),
      )
      .toList();

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

  @computed
  StoreState get categoriesState {
    if (_categoriesFuture == null) {
      return StoreState.initial;
    }

    return _categoriesFuture!.status == FutureStatus.pending
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
  Future<void> fetchCategories() async {
    _categoriesFuture = ObservableFuture(_categoriesProvider.getCategories());
    categories = ObservableList.of(await _categoriesFuture!);
  }

  @action
  search() async {
    filteredRecentEvents = ObservableList();

    if (name != null && name!.isNotEmpty) {
      filteredRecentEvents = ObservableList.of(upcommingEvents.where(
          (element) =>
              element.eventName.toLowerCase().contains(name!.toLowerCase())));
    }
  }
}
