// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendors_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$VendorsStore on _VendorsStoreBase, Store {
  Computed<VendorsStoreState>? _$recentVendorsStateComputed;

  @override
  VendorsStoreState get recentVendorsState => (_$recentVendorsStateComputed ??=
          Computed<VendorsStoreState>(() => super.recentVendorsState,
              name: '_VendorsStoreBase.recentVendorsState'))
      .value;

  late final _$_recentVendorsFutureAtom =
      Atom(name: '_VendorsStoreBase._recentVendorsFuture', context: context);

  @override
  ObservableFuture<PaginatorDto<VendorModel>>? get _recentVendorsFuture {
    _$_recentVendorsFutureAtom.reportRead();
    return super._recentVendorsFuture;
  }

  @override
  set _recentVendorsFuture(ObservableFuture<PaginatorDto<VendorModel>>? value) {
    _$_recentVendorsFutureAtom.reportWrite(value, super._recentVendorsFuture,
        () {
      super._recentVendorsFuture = value;
    });
  }

  late final _$recentVendorsAtom =
      Atom(name: '_VendorsStoreBase.recentVendors', context: context);

  @override
  List<VendorModel> get recentVendors {
    _$recentVendorsAtom.reportRead();
    return super.recentVendors;
  }

  @override
  set recentVendors(List<VendorModel> value) {
    _$recentVendorsAtom.reportWrite(value, super.recentVendors, () {
      super.recentVendors = value;
    });
  }

  late final _$currentPageAtom =
      Atom(name: '_VendorsStoreBase.currentPage', context: context);

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$nameAtom =
      Atom(name: '_VendorsStoreBase.name', context: context);

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$locationAtom =
      Atom(name: '_VendorsStoreBase.location', context: context);

  @override
  String? get location {
    _$locationAtom.reportRead();
    return super.location;
  }

  @override
  set location(String? value) {
    _$locationAtom.reportWrite(value, super.location, () {
      super.location = value;
    });
  }

  late final _$areaAtom =
      Atom(name: '_VendorsStoreBase.area', context: context);

  @override
  String? get area {
    _$areaAtom.reportRead();
    return super.area;
  }

  @override
  set area(String? value) {
    _$areaAtom.reportWrite(value, super.area, () {
      super.area = value;
    });
  }

  late final _$brandAtom =
      Atom(name: '_VendorsStoreBase.brand', context: context);

  @override
  String? get brand {
    _$brandAtom.reportRead();
    return super.brand;
  }

  @override
  set brand(String? value) {
    _$brandAtom.reportWrite(value, super.brand, () {
      super.brand = value;
    });
  }

  late final _$hasErrorsAtom =
      Atom(name: '_VendorsStoreBase.hasErrors', context: context);

  @override
  bool? get hasErrors {
    _$hasErrorsAtom.reportRead();
    return super.hasErrors;
  }

  @override
  set hasErrors(bool? value) {
    _$hasErrorsAtom.reportWrite(value, super.hasErrors, () {
      super.hasErrors = value;
    });
  }

  late final _$loadRecentVendorsAsyncAction =
      AsyncAction('_VendorsStoreBase.loadRecentVendors', context: context);

  @override
  Future<void> loadRecentVendors() {
    return _$loadRecentVendorsAsyncAction.run(() => super.loadRecentVendors());
  }

  late final _$_VendorsStoreBaseActionController =
      ActionController(name: '_VendorsStoreBase', context: context);

  @override
  dynamic setArea(String value) {
    final _$actionInfo = _$_VendorsStoreBaseActionController.startAction(
        name: '_VendorsStoreBase.setArea');
    try {
      return super.setArea(value);
    } finally {
      _$_VendorsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setName(String value) {
    final _$actionInfo = _$_VendorsStoreBaseActionController.startAction(
        name: '_VendorsStoreBase.setName');
    try {
      return super.setName(value);
    } finally {
      _$_VendorsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLocation(String value) {
    final _$actionInfo = _$_VendorsStoreBaseActionController.startAction(
        name: '_VendorsStoreBase.setLocation');
    try {
      return super.setLocation(value);
    } finally {
      _$_VendorsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setBrand(String value) {
    final _$actionInfo = _$_VendorsStoreBaseActionController.startAction(
        name: '_VendorsStoreBase.setBrand');
    try {
      return super.setBrand(value);
    } finally {
      _$_VendorsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void search() {
    final _$actionInfo = _$_VendorsStoreBaseActionController.startAction(
        name: '_VendorsStoreBase.search');
    try {
      return super.search();
    } finally {
      _$_VendorsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
recentVendors: ${recentVendors},
currentPage: ${currentPage},
name: ${name},
location: ${location},
area: ${area},
brand: ${brand},
hasErrors: ${hasErrors},
recentVendorsState: ${recentVendorsState}
    ''';
  }
}
