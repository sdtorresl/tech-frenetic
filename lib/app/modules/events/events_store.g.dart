// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EventsStore on _EventsStore, Store {
  Computed<StoreState>? _$categoriesStateComputed;

  @override
  StoreState get categoriesState => (_$categoriesStateComputed ??=
          Computed<StoreState>(() => super.categoriesState,
              name: '_EventsStore.categoriesState'))
      .value;
  Computed<List<SelectableItem>>? _$selectableCategoriesComputed;

  @override
  List<SelectableItem> get selectableCategories =>
      (_$selectableCategoriesComputed ??= Computed<List<SelectableItem>>(
              () => super.selectableCategories,
              name: '_EventsStore.selectableCategories'))
          .value;

  late final _$recentEventsStoreAtom =
      Atom(name: '_EventsStore.recentEventsStore', context: context);

  @override
  RecentEventsStore get recentEventsStore {
    _$recentEventsStoreAtom.reportRead();
    return super.recentEventsStore;
  }

  @override
  set recentEventsStore(RecentEventsStore value) {
    _$recentEventsStoreAtom.reportWrite(value, super.recentEventsStore, () {
      super.recentEventsStore = value;
    });
  }

  late final _$_categoriesFutureAtom =
      Atom(name: '_EventsStore._categoriesFuture', context: context);

  @override
  ObservableFuture<List<CategoriesModel>>? get _categoriesFuture {
    _$_categoriesFutureAtom.reportRead();
    return super._categoriesFuture;
  }

  @override
  set _categoriesFuture(ObservableFuture<List<CategoriesModel>>? value) {
    _$_categoriesFutureAtom.reportWrite(value, super._categoriesFuture, () {
      super._categoriesFuture = value;
    });
  }

  late final _$_categoriesAtom =
      Atom(name: '_EventsStore._categories', context: context);

  @override
  ObservableList<CategoriesModel> get _categories {
    _$_categoriesAtom.reportRead();
    return super._categories;
  }

  @override
  set _categories(ObservableList<CategoriesModel> value) {
    _$_categoriesAtom.reportWrite(value, super._categories, () {
      super._categories = value;
    });
  }

  late final _$fetchCategoriesAsyncAction =
      AsyncAction('_EventsStore.fetchCategories', context: context);

  @override
  Future<void> fetchCategories() {
    return _$fetchCategoriesAsyncAction.run(() => super.fetchCategories());
  }

  @override
  String toString() {
    return '''
recentEventsStore: ${recentEventsStore},
categoriesState: ${categoriesState},
selectableCategories: ${selectableCategories}
    ''';
  }
}
