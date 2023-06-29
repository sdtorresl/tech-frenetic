// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcomming_events_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UpcommingEventsStore on _UpcommingEventsStore, Store {
  Computed<List<SelectableItem<dynamic>>>? _$selectableCategoriesComputed;

  @override
  List<SelectableItem<dynamic>> get selectableCategories =>
      (_$selectableCategoriesComputed ??=
              Computed<List<SelectableItem<dynamic>>>(
                  () => super.selectableCategories,
                  name: '_UpcommingEventsStore.selectableCategories'))
          .value;
  Computed<StoreState>? _$upcommingEventsStateComputed;

  @override
  StoreState get upcommingEventsState => (_$upcommingEventsStateComputed ??=
          Computed<StoreState>(() => super.upcommingEventsState,
              name: '_UpcommingEventsStore.upcommingEventsState'))
      .value;
  Computed<StoreState>? _$categoriesStateComputed;

  @override
  StoreState get categoriesState => (_$categoriesStateComputed ??=
          Computed<StoreState>(() => super.categoriesState,
              name: '_UpcommingEventsStore.categoriesState'))
      .value;

  late final _$_upcommingEventsFutureAtom = Atom(
      name: '_UpcommingEventsStore._upcommingEventsFuture', context: context);

  @override
  ObservableFuture<List<EventsModel>>? get _upcommingEventsFuture {
    _$_upcommingEventsFutureAtom.reportRead();
    return super._upcommingEventsFuture;
  }

  @override
  set _upcommingEventsFuture(ObservableFuture<List<EventsModel>>? value) {
    _$_upcommingEventsFutureAtom
        .reportWrite(value, super._upcommingEventsFuture, () {
      super._upcommingEventsFuture = value;
    });
  }

  late final _$_categoriesFutureAtom =
      Atom(name: '_UpcommingEventsStore._categoriesFuture', context: context);

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

  late final _$categoriesAtom =
      Atom(name: '_UpcommingEventsStore.categories', context: context);

  @override
  ObservableList<CategoriesModel> get categories {
    _$categoriesAtom.reportRead();
    return super.categories;
  }

  @override
  set categories(ObservableList<CategoriesModel> value) {
    _$categoriesAtom.reportWrite(value, super.categories, () {
      super.categories = value;
    });
  }

  late final _$upcommingEventsAtom =
      Atom(name: '_UpcommingEventsStore.upcommingEvents', context: context);

  @override
  ObservableList<EventsModel> get upcommingEvents {
    _$upcommingEventsAtom.reportRead();
    return super.upcommingEvents;
  }

  @override
  set upcommingEvents(ObservableList<EventsModel> value) {
    _$upcommingEventsAtom.reportWrite(value, super.upcommingEvents, () {
      super.upcommingEvents = value;
    });
  }

  late final _$filteredRecentEventsAtom = Atom(
      name: '_UpcommingEventsStore.filteredRecentEvents', context: context);

  @override
  ObservableList<EventsModel> get filteredRecentEvents {
    _$filteredRecentEventsAtom.reportRead();
    return super.filteredRecentEvents;
  }

  @override
  set filteredRecentEvents(ObservableList<EventsModel> value) {
    _$filteredRecentEventsAtom.reportWrite(value, super.filteredRecentEvents,
        () {
      super.filteredRecentEvents = value;
    });
  }

  late final _$categoryAtom =
      Atom(name: '_UpcommingEventsStore.category', context: context);

  @override
  SelectableItem<dynamic>? get category {
    _$categoryAtom.reportRead();
    return super.category;
  }

  @override
  set category(SelectableItem<dynamic>? value) {
    _$categoryAtom.reportWrite(value, super.category, () {
      super.category = value;
    });
  }

  late final _$fetchUpcommingEventsAsyncAction = AsyncAction(
      '_UpcommingEventsStore.fetchUpcommingEvents',
      context: context);

  @override
  Future<dynamic> fetchUpcommingEvents() {
    return _$fetchUpcommingEventsAsyncAction
        .run(() => super.fetchUpcommingEvents());
  }

  late final _$fetchCategoriesAsyncAction =
      AsyncAction('_UpcommingEventsStore.fetchCategories', context: context);

  @override
  Future<void> fetchCategories() {
    return _$fetchCategoriesAsyncAction.run(() => super.fetchCategories());
  }

  late final _$searchAsyncAction =
      AsyncAction('_UpcommingEventsStore.search', context: context);

  @override
  Future search() {
    return _$searchAsyncAction.run(() => super.search());
  }

  late final _$_UpcommingEventsStoreActionController =
      ActionController(name: '_UpcommingEventsStore', context: context);

  @override
  void changeDate(DateTime? dateTime) {
    final _$actionInfo = _$_UpcommingEventsStoreActionController.startAction(
        name: '_UpcommingEventsStore.changeDate');
    try {
      return super.changeDate(dateTime);
    } finally {
      _$_UpcommingEventsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
categories: ${categories},
upcommingEvents: ${upcommingEvents},
filteredRecentEvents: ${filteredRecentEvents},
category: ${category},
selectableCategories: ${selectableCategories},
upcommingEventsState: ${upcommingEventsState},
categoriesState: ${categoriesState}
    ''';
  }
}
