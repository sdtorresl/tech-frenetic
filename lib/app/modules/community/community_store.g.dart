// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CommunityStore on _CommunityStore, Store {
  Computed<StoreState>? _$stateComputed;

  @override
  StoreState get state =>
      (_$stateComputed ??= Computed<StoreState>(() => super.state,
              name: '_CommunityStore.state'))
          .value;

  late final _$advertisementAtom =
      Atom(name: '_CommunityStore.advertisement', context: context);

  @override
  AdvertisementModel? get advertisement {
    _$advertisementAtom.reportRead();
    return super.advertisement;
  }

  @override
  set advertisement(AdvertisementModel? value) {
    _$advertisementAtom.reportWrite(value, super.advertisement, () {
      super.advertisement = value;
    });
  }

  late final _$_advertisementFutureAtom =
      Atom(name: '_CommunityStore._advertisementFuture', context: context);

  @override
  ObservableFuture<AdvertisementModel?>? get _advertisementFuture {
    _$_advertisementFutureAtom.reportRead();
    return super._advertisementFuture;
  }

  @override
  set _advertisementFuture(ObservableFuture<AdvertisementModel?>? value) {
    _$_advertisementFutureAtom.reportWrite(value, super._advertisementFuture,
        () {
      super._advertisementFuture = value;
    });
  }

  late final _$fetchVideoAsyncAction =
      AsyncAction('_CommunityStore.fetchVideo', context: context);

  @override
  Future<dynamic> fetchVideo() {
    return _$fetchVideoAsyncAction.run(() => super.fetchVideo());
  }

  @override
  String toString() {
    return '''
advertisement: ${advertisement},
state: ${state}
    ''';
  }
}
