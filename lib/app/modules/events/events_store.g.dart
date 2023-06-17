// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EventsStore on _EventsStore, Store {
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

  @override
  String toString() {
    return '''
recentEventsStore: ${recentEventsStore}
    ''';
  }
}
