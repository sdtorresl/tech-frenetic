import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:techfrenetic/app/modules/events/recent_events_store.dart';

import '../../core/utils/selectable_item.dart';
import '../../models/categories_model.dart';
import '../../providers/categories_provider.dart';

part 'events_store.g.dart';

class EventsStore = _EventsStore with _$EventsStore;

enum StoreState { initial, loading, loaded }

abstract class _EventsStore with Store {
  final _categoriesProvider = Modular.get<CategoriesProvider>();

  @observable
  RecentEventsStore recentEventsStore = Modular.get();

  @observable
  ObservableFuture<List<CategoriesModel>>? _categoriesFuture;

  @observable
  ObservableList<CategoriesModel> _categories = ObservableList.of([]);

  @action
  Future<void> fetchCategories() async {
    _categoriesFuture = ObservableFuture(_categoriesProvider.getCategories());
    _categories = ObservableList.of(await _categoriesFuture!);
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
