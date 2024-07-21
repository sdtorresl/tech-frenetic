import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:techfrenetic/app/models/events_model.dart';
import 'package:techfrenetic/app/modules/events/recent_events_store.dart';
import 'package:techfrenetic/app/providers/events_provider.dart';

import '../../core/utils/selectable_item.dart';
import '../../models/categories_model.dart';
import '../../providers/categories_provider.dart';

part 'events_store.g.dart';

class EventsStore = _EventsStore with _$EventsStore;

enum StoreState { initial, loading, loaded }

abstract class _EventsStore with Store {
  final _categoriesProvider = Modular.get<CategoriesProvider>();
  final _eventsProvider = Modular.get<EventsProvider>();

  @observable
  RecentEventsStore recentEventsStore = Modular.get();

  @observable
  ObservableFuture<List<CategoriesModel>>? _categoriesFuture;

  @observable
  ObservableFuture<List<EventsModel>>? _featuredEventsFuture;

  @observable
  ObservableList<CategoriesModel> _categories = ObservableList.of([]);

  @observable
  ObservableList<EventsModel> featuredEvents = ObservableList.of([]);

  @action
  Future<void> fetchFeaturedEvents() async {
    _featuredEventsFuture =
        ObservableFuture(_eventsProvider.getFeaturedEvents());
    featuredEvents = ObservableList.of(await _featuredEventsFuture!);
  }

  @action
  Future<void> fetchCategories() async {
    _categoriesFuture = ObservableFuture(_categoriesProvider.getCategories());
    _categories = ObservableList.of(await _categoriesFuture!);
  }

  @computed
  StoreState get featuredEventsState {
    if (_featuredEventsFuture == null) {
      return StoreState.initial;
    }

    return _featuredEventsFuture!.status == FutureStatus.pending
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

  @computed
  List<SelectableItem> get selectableCategories {
    var _selectableCat = _categories
        .map(
          (cat) => SelectableItem(label: cat.category, value: cat.id),
        )
        .toList();
    if (_selectableCat.isNotEmpty) {
      _selectableCat.add(SelectableItem(label: 'All', value: null));
    }

    return _selectableCat;
  }
}
