// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_events_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RecentEventsStore on _RecentEventsStore, Store {
  Computed<StoreState>? _$stateComputed;

  @override
  StoreState get state =>
      (_$stateComputed ??= Computed<StoreState>(() => super.state,
              name: '_RecentEventsStore.state'))
          .value;

  late final _$_recentEventsFutureAtom =
      Atom(name: '_RecentEventsStore._recentEventsFuture', context: context);

  @override
  ObservableFuture<List<EventsModel>>? get _recentEventsFuture {
    _$_recentEventsFutureAtom.reportRead();
    return super._recentEventsFuture;
  }

  @override
  set _recentEventsFuture(ObservableFuture<List<EventsModel>>? value) {
    _$_recentEventsFutureAtom.reportWrite(value, super._recentEventsFuture, () {
      super._recentEventsFuture = value;
    });
  }

  late final _$recentEventsAtom =
      Atom(name: '_RecentEventsStore.recentEvents', context: context);

  @override
  ObservableList<EventsModel> get recentEvents {
    _$recentEventsAtom.reportRead();
    return super.recentEvents;
  }

  @override
  set recentEvents(ObservableList<EventsModel> value) {
    _$recentEventsAtom.reportWrite(value, super.recentEvents, () {
      super.recentEvents = value;
    });
  }

  late final _$filteredRecentEventsAtom =
      Atom(name: '_RecentEventsStore.filteredRecentEvents', context: context);

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

  late final _$fetchRecentEventsAsyncAction =
      AsyncAction('_RecentEventsStore.fetchRecentEvents', context: context);

  @override
  Future<dynamic> fetchRecentEvents() {
    return _$fetchRecentEventsAsyncAction.run(() => super.fetchRecentEvents());
  }

  late final _$searchAsyncAction =
      AsyncAction('_RecentEventsStore.search', context: context);

  @override
  Future search() {
    return _$searchAsyncAction.run(() => super.search());
  }

  @override
  String toString() {
    return '''
recentEvents: ${recentEvents},
filteredRecentEvents: ${filteredRecentEvents},
state: ${state}
    ''';
  }
}
