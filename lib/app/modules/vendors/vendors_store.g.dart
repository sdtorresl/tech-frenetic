// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendors_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$VendorsStore on _VendorsStoreBase, Store {
  Computed<BrandsStoreState>? _$brandsStateComputed;

  @override
  BrandsStoreState get brandsState => (_$brandsStateComputed ??=
          Computed<BrandsStoreState>(() => super.brandsState,
              name: '_VendorsStoreBase.brandsState'))
      .value;
  Computed<ServicesStoreState>? _$servicesStateComputed;

  @override
  ServicesStoreState get servicesState => (_$servicesStateComputed ??=
          Computed<ServicesStoreState>(() => super.servicesState,
              name: '_VendorsStoreBase.servicesState'))
      .value;
  Computed<VendorDescriptionStoreState>? _$vendorDescriptionStateComputed;

  @override
  VendorDescriptionStoreState get vendorDescriptionState =>
      (_$vendorDescriptionStateComputed ??=
              Computed<VendorDescriptionStoreState>(
                  () => super.vendorDescriptionState,
                  name: '_VendorsStoreBase.vendorDescriptionState'))
          .value;
  Computed<RecentVendorsStoreState>? _$recentVendorsStateComputed;

  @override
  RecentVendorsStoreState get recentVendorsState =>
      (_$recentVendorsStateComputed ??= Computed<RecentVendorsStoreState>(
              () => super.recentVendorsState,
              name: '_VendorsStoreBase.recentVendorsState'))
          .value;
  Computed<SearchVendorsStoreState>? _$searchVendorsStateComputed;

  @override
  SearchVendorsStoreState get searchVendorsState =>
      (_$searchVendorsStateComputed ??= Computed<SearchVendorsStoreState>(
              () => super.searchVendorsState,
              name: '_VendorsStoreBase.searchVendorsState'))
          .value;

  late final _$_vendorsDescriptionFutureAtom = Atom(
      name: '_VendorsStoreBase._vendorsDescriptionFuture', context: context);

  @override
  ObservableFuture<VendorDescriptionModel>? get _vendorsDescriptionFuture {
    _$_vendorsDescriptionFutureAtom.reportRead();
    return super._vendorsDescriptionFuture;
  }

  @override
  set _vendorsDescriptionFuture(
      ObservableFuture<VendorDescriptionModel>? value) {
    _$_vendorsDescriptionFutureAtom
        .reportWrite(value, super._vendorsDescriptionFuture, () {
      super._vendorsDescriptionFuture = value;
    });
  }

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

  late final _$_vendorsFutureAtom =
      Atom(name: '_VendorsStoreBase._vendorsFuture', context: context);

  @override
  ObservableFuture<PaginatorDto<VendorModel>>? get _vendorsFuture {
    _$_vendorsFutureAtom.reportRead();
    return super._vendorsFuture;
  }

  @override
  set _vendorsFuture(ObservableFuture<PaginatorDto<VendorModel>>? value) {
    _$_vendorsFutureAtom.reportWrite(value, super._vendorsFuture, () {
      super._vendorsFuture = value;
    });
  }

  late final _$_servicesFutureAtom =
      Atom(name: '_VendorsStoreBase._servicesFuture', context: context);

  @override
  ObservableFuture<List<CategoriesModel>>? get _servicesFuture {
    _$_servicesFutureAtom.reportRead();
    return super._servicesFuture;
  }

  @override
  set _servicesFuture(ObservableFuture<List<CategoriesModel>>? value) {
    _$_servicesFutureAtom.reportWrite(value, super._servicesFuture, () {
      super._servicesFuture = value;
    });
  }

  late final _$_brandsFutureAtom =
      Atom(name: '_VendorsStoreBase._brandsFuture', context: context);

  @override
  ObservableFuture<List<CategoriesModel>>? get _brandsFuture {
    _$_brandsFutureAtom.reportRead();
    return super._brandsFuture;
  }

  @override
  set _brandsFuture(ObservableFuture<List<CategoriesModel>>? value) {
    _$_brandsFutureAtom.reportWrite(value, super._brandsFuture, () {
      super._brandsFuture = value;
    });
  }

  late final _$servicesAtom =
      Atom(name: '_VendorsStoreBase.services', context: context);

  @override
  ObservableList<CategoriesModel> get services {
    _$servicesAtom.reportRead();
    return super.services;
  }

  @override
  set services(ObservableList<CategoriesModel> value) {
    _$servicesAtom.reportWrite(value, super.services, () {
      super.services = value;
    });
  }

  late final _$brandsAtom =
      Atom(name: '_VendorsStoreBase.brands', context: context);

  @override
  ObservableList<CategoriesModel> get brands {
    _$brandsAtom.reportRead();
    return super.brands;
  }

  @override
  set brands(ObservableList<CategoriesModel> value) {
    _$brandsAtom.reportWrite(value, super.brands, () {
      super.brands = value;
    });
  }

  late final _$vendorsAtom =
      Atom(name: '_VendorsStoreBase.vendors', context: context);

  @override
  ObservableList<VendorModel> get vendors {
    _$vendorsAtom.reportRead();
    return super.vendors;
  }

  @override
  set vendors(ObservableList<VendorModel> value) {
    _$vendorsAtom.reportWrite(value, super.vendors, () {
      super.vendors = value;
    });
  }

  late final _$recentVendorsAtom =
      Atom(name: '_VendorsStoreBase.recentVendors', context: context);

  @override
  ObservableList<VendorModel> get recentVendors {
    _$recentVendorsAtom.reportRead();
    return super.recentVendors;
  }

  @override
  set recentVendors(ObservableList<VendorModel> value) {
    _$recentVendorsAtom.reportWrite(value, super.recentVendors, () {
      super.recentVendors = value;
    });
  }

  late final _$descriptionAtom =
      Atom(name: '_VendorsStoreBase.description', context: context);

  @override
  VendorDescriptionModel? get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(VendorDescriptionModel? value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  late final _$paginatorAtom =
      Atom(name: '_VendorsStoreBase.paginator', context: context);

  @override
  PaginatorDto<VendorModel> get paginator {
    _$paginatorAtom.reportRead();
    return super.paginator;
  }

  @override
  set paginator(PaginatorDto<VendorModel> value) {
    _$paginatorAtom.reportWrite(value, super.paginator, () {
      super.paginator = value;
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

  late final _$serviceAtom =
      Atom(name: '_VendorsStoreBase.service', context: context);

  @override
  CategoriesModel? get service {
    _$serviceAtom.reportRead();
    return super.service;
  }

  @override
  set service(CategoriesModel? value) {
    _$serviceAtom.reportWrite(value, super.service, () {
      super.service = value;
    });
  }

  late final _$brandAtom =
      Atom(name: '_VendorsStoreBase.brand', context: context);

  @override
  CategoriesModel? get brand {
    _$brandAtom.reportRead();
    return super.brand;
  }

  @override
  set brand(CategoriesModel? value) {
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

  late final _$loadDescriptionAsyncAction =
      AsyncAction('_VendorsStoreBase.loadDescription', context: context);

  @override
  Future<void> loadDescription() {
    return _$loadDescriptionAsyncAction.run(() => super.loadDescription());
  }

  late final _$loadRecentVendorsAsyncAction =
      AsyncAction('_VendorsStoreBase.loadRecentVendors', context: context);

  @override
  Future<void> loadRecentVendors() {
    return _$loadRecentVendorsAsyncAction.run(() => super.loadRecentVendors());
  }

  late final _$loadServicesAsyncAction =
      AsyncAction('_VendorsStoreBase.loadServices', context: context);

  @override
  Future<void> loadServices() {
    return _$loadServicesAsyncAction.run(() => super.loadServices());
  }

  late final _$loadBrandsAsyncAction =
      AsyncAction('_VendorsStoreBase.loadBrands', context: context);

  @override
  Future<void> loadBrands() {
    return _$loadBrandsAsyncAction.run(() => super.loadBrands());
  }

  late final _$searchVendorsAsyncAction =
      AsyncAction('_VendorsStoreBase.searchVendors', context: context);

  @override
  Future<void> searchVendors() {
    return _$searchVendorsAsyncAction.run(() => super.searchVendors());
  }

  late final _$_VendorsStoreBaseActionController =
      ActionController(name: '_VendorsStoreBase', context: context);

  @override
  dynamic setService(CategoriesModel? value) {
    final _$actionInfo = _$_VendorsStoreBaseActionController.startAction(
        name: '_VendorsStoreBase.setService');
    try {
      return super.setService(value);
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
  dynamic setBrand(CategoriesModel? value) {
    final _$actionInfo = _$_VendorsStoreBaseActionController.startAction(
        name: '_VendorsStoreBase.setBrand');
    try {
      return super.setBrand(value);
    } finally {
      _$_VendorsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changePage(int page) {
    final _$actionInfo = _$_VendorsStoreBaseActionController.startAction(
        name: '_VendorsStoreBase.changePage');
    try {
      return super.changePage(page);
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
  void clean() {
    final _$actionInfo = _$_VendorsStoreBaseActionController.startAction(
        name: '_VendorsStoreBase.clean');
    try {
      return super.clean();
    } finally {
      _$_VendorsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
services: ${services},
brands: ${brands},
vendors: ${vendors},
recentVendors: ${recentVendors},
description: ${description},
paginator: ${paginator},
name: ${name},
location: ${location},
service: ${service},
brand: ${brand},
hasErrors: ${hasErrors},
brandsState: ${brandsState},
servicesState: ${servicesState},
vendorDescriptionState: ${vendorDescriptionState},
recentVendorsState: ${recentVendorsState},
searchVendorsState: ${searchVendorsState}
    ''';
  }
}
