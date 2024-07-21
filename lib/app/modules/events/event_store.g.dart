// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EventStore on _EventStore, Store {
  Computed<StoreState>? _$stateComputed;

  @override
  StoreState get state => (_$stateComputed ??=
          Computed<StoreState>(() => super.state, name: '_EventStore.state'))
      .value;

  late final _$eventAtom = Atom(name: '_EventStore.event', context: context);

  @override
  DetailedEventModel? get event {
    _$eventAtom.reportRead();
    return super.event;
  }

  @override
  set event(DetailedEventModel? value) {
    _$eventAtom.reportWrite(value, super.event, () {
      super.event = value;
    });
  }

  late final _$_eventFutureAtom =
      Atom(name: '_EventStore._eventFuture', context: context);

  @override
  ObservableFuture<DetailedEventModel?>? get _eventFuture {
    _$_eventFutureAtom.reportRead();
    return super._eventFuture;
  }

  @override
  set _eventFuture(ObservableFuture<DetailedEventModel?>? value) {
    _$_eventFutureAtom.reportWrite(value, super._eventFuture, () {
      super._eventFuture = value;
    });
  }

  late final _$fetchEventAsyncAction =
      AsyncAction('_EventStore.fetchEvent', context: context);

  @override
  Future<dynamic> fetchEvent(String slug) {
    return _$fetchEventAsyncAction.run(() => super.fetchEvent(slug));
  }

  @override
  String toString() {
    return '''
event: ${event},
state: ${state}
    ''';
  }
}
