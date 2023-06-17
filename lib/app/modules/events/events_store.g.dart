// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EventsStore on _EventsStore, Store {
  late final _$recentEventsFutureAtom =
      Atom(name: '_EventsStore.recentEventsFuture', context: context);

  @override
  ObservableFuture<List<EventsModel>>? get recentEventsFuture {
    _$recentEventsFutureAtom.reportRead();
    return super.recentEventsFuture;
  }

  @override
  set recentEventsFuture(ObservableFuture<List<EventsModel>>? value) {
    _$recentEventsFutureAtom.reportWrite(value, super.recentEventsFuture, () {
      super.recentEventsFuture = value;
    });
  }

  late final _$_EventsStoreActionController =
      ActionController(name: '_EventsStore', context: context);

  @override
  Future<dynamic> fetchRecentEvents() {
    final _$actionInfo = _$_EventsStoreActionController.startAction(
        name: '_EventsStore.fetchRecentEvents');
    try {
      return super.fetchRecentEvents();
    } finally {
      _$_EventsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
recentEventsFuture: ${recentEventsFuture}
    ''';
  }
}
