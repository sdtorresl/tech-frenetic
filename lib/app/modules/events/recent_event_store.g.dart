// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_event_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RecentEventStore on _RecentEventStore, Store {
  Computed<RecentEventStoreState>? _$stateComputed;

  @override
  RecentEventStoreState get state =>
      (_$stateComputed ??= Computed<RecentEventStoreState>(() => super.state,
              name: '_RecentEventStore.state'))
          .value;

  late final _$_recentEventFutureAtom =
      Atom(name: '_RecentEventStore._recentEventFuture', context: context);

  @override
  ObservableFuture<EventsModel?>? get _recentEventFuture {
    _$_recentEventFutureAtom.reportRead();
    return super._recentEventFuture;
  }

  @override
  set _recentEventFuture(ObservableFuture<EventsModel?>? value) {
    _$_recentEventFutureAtom.reportWrite(value, super._recentEventFuture, () {
      super._recentEventFuture = value;
    });
  }

  late final _$eventAtom =
      Atom(name: '_RecentEventStore.event', context: context);

  @override
  EventsModel? get event {
    _$eventAtom.reportRead();
    return super.event;
  }

  @override
  set event(EventsModel? value) {
    _$eventAtom.reportWrite(value, super.event, () {
      super.event = value;
    });
  }

  late final _$fetchRecentEventsAsyncAction =
      AsyncAction('_RecentEventStore.fetchRecentEvents', context: context);

  @override
  Future<dynamic> fetchRecentEvents() {
    return _$fetchRecentEventsAsyncAction.run(() => super.fetchRecentEvents());
  }

  @override
  String toString() {
    return '''
event: ${event},
state: ${state}
    ''';
  }
}
