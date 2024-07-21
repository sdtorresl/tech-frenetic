import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:techfrenetic/app/models/categories_model.dart';
import 'package:techfrenetic/app/models/dtos/paginator_dto.dart';
import 'package:techfrenetic/app/models/dtos/vendor_filter_dto.dart';
import 'package:techfrenetic/app/models/vendor_model.dart';
import 'package:techfrenetic/app/providers/categories_provider.dart';
import 'package:techfrenetic/app/providers/vendors_provider.dart';

import '../../models/vendor_description.dart';

part 'vendors_store.g.dart';

class VendorsStore = _VendorsStoreBase with _$VendorsStore;

enum VendorDescriptionStoreState { initial, loading, loaded, error }

enum RecentVendorsStoreState { initial, loading, loaded, error }

enum SearchVendorsStoreState { initial, loading, loaded, error }

enum BrandsStoreState { initial, loading, loaded, error }

enum ServicesStoreState { initial, loading, loaded, error }

abstract class _VendorsStoreBase with Store {
  final _vendorsProvider = Modular.get<VendorsProvider>();
  final _categoriesProvider = Modular.get<CategoriesProvider>();

  @observable
  ObservableFuture<VendorDescriptionModel>? _vendorsDescriptionFuture;

  @observable
  ObservableFuture<PaginatorDto<VendorModel>>? _recentVendorsFuture;

  @observable
  ObservableFuture<PaginatorDto<VendorModel>>? _vendorsFuture;

  @observable
  ObservableFuture<List<CategoriesModel>>? _servicesFuture;

  @observable
  ObservableFuture<List<CategoriesModel>>? _brandsFuture;

  @observable
  ObservableList<CategoriesModel> services = ObservableList.of([]);

  @observable
  ObservableList<CategoriesModel> brands = ObservableList.of([]);

  @observable
  ObservableList<VendorModel> vendors = ObservableList.of([]);

  @observable
  ObservableList<VendorModel> recentVendors = ObservableList.of([]);

  @observable
  VendorDescriptionModel? description;

  @observable
  PaginatorDto<VendorModel> paginator = PaginatorDto(
      totalItems: 0, itemsPerPage: 0, totalPages: 0, currentPage: 0);

  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @observable
  String? name;

  @observable
  String? location;

  @observable
  CategoriesModel? service;

  @observable
  CategoriesModel? brand;

  GlobalKey<FormFieldState> brandSelectorKey = GlobalKey();

  GlobalKey<FormFieldState> serviceSelectorKey = GlobalKey();

  @observable
  bool? hasErrors;

  _VendorsStoreBase() {
    _initControllers();
    loadBrands();
    loadServices();
    loadDescription();
    loadRecentVendors();
  }

  @action
  setService(CategoriesModel? value) {
    service = value;
  }

  @action
  setName(String value) {
    name = value;
  }

  @action
  setLocation(String value) {
    location = value;
  }

  @action
  setBrand(CategoriesModel? value) {
    brand = value;
  }

  @action
  Future<void> loadDescription() async {
    _vendorsDescriptionFuture =
        ObservableFuture(_vendorsProvider.getVendorDescription());
    description = await _vendorsDescriptionFuture;
  }

  @action
  Future<void> loadRecentVendors() async {
    _recentVendorsFuture =
        ObservableFuture(_vendorsProvider.getRecentVendors(page: 0));
    recentVendors = ObservableList.of((await _recentVendorsFuture!).items);
  }

  @action
  Future<void> loadServices() async {
    _servicesFuture = ObservableFuture(_categoriesProvider.getServices());
    services = ObservableList.of(await _servicesFuture!);
  }

  @action
  Future<void> loadBrands() async {
    _brandsFuture = ObservableFuture(_categoriesProvider.getBrands());
    brands = ObservableList.of(await _brandsFuture!);
  }

  @action
  Future<void> searchVendors() async {
    var _filter = VendorFilterDto(
      name: name,
      brand: brand?.id,
      area: service?.id,
      location: location,
    );
    _vendorsFuture = ObservableFuture(_vendorsProvider.searchVendors(
      page: paginator.currentPage,
      filter: _filter,
    ));
    paginator = await _vendorsFuture!;
    vendors = ObservableList.of(paginator.items);
  }

  @action
  void changePage(int page) {
    paginator.currentPage = page;
    searchVendors();
  }

  @computed
  BrandsStoreState get brandsState {
    if (_brandsFuture == null) {
      return BrandsStoreState.initial;
    }

    switch (_brandsFuture!.status) {
      case FutureStatus.pending:
        return BrandsStoreState.loading;
      case FutureStatus.fulfilled:
        return BrandsStoreState.loaded;
      case FutureStatus.rejected:
        return BrandsStoreState.error;
      default:
        return BrandsStoreState.initial;
    }
  }

  @computed
  ServicesStoreState get servicesState {
    if (_brandsFuture == null) {
      return ServicesStoreState.initial;
    }

    switch (_brandsFuture!.status) {
      case FutureStatus.pending:
        return ServicesStoreState.loading;
      case FutureStatus.fulfilled:
        return ServicesStoreState.loaded;
      case FutureStatus.rejected:
        return ServicesStoreState.error;
      default:
        return ServicesStoreState.initial;
    }
  }

  @computed
  VendorDescriptionStoreState get vendorDescriptionState {
    if (_vendorsDescriptionFuture == null) {
      return VendorDescriptionStoreState.initial;
    }

    switch (_vendorsDescriptionFuture!.status) {
      case FutureStatus.pending:
        return VendorDescriptionStoreState.loading;
      case FutureStatus.fulfilled:
        return VendorDescriptionStoreState.loaded;
      case FutureStatus.rejected:
        return VendorDescriptionStoreState.error;
      default:
        return VendorDescriptionStoreState.initial;
    }
  }

  @computed
  RecentVendorsStoreState get recentVendorsState {
    if (_recentVendorsFuture == null) {
      return RecentVendorsStoreState.initial;
    }

    switch (_recentVendorsFuture!.status) {
      case FutureStatus.pending:
        return RecentVendorsStoreState.loading;
      case FutureStatus.fulfilled:
        return RecentVendorsStoreState.loaded;
      case FutureStatus.rejected:
        return RecentVendorsStoreState.error;
      default:
        return RecentVendorsStoreState.initial;
    }
  }

  @computed
  SearchVendorsStoreState get searchVendorsState {
    if (_recentVendorsFuture == null) {
      return SearchVendorsStoreState.initial;
    }

    switch (_recentVendorsFuture!.status) {
      case FutureStatus.pending:
        return SearchVendorsStoreState.loading;
      case FutureStatus.fulfilled:
        return SearchVendorsStoreState.loaded;
      case FutureStatus.rejected:
        return SearchVendorsStoreState.error;
      default:
        return SearchVendorsStoreState.initial;
    }
  }

  @action
  void search() {
    searchVendors();
  }

  @action
  void clean() {
    name = null;
    location = null;
    service = null;
    brand = null;
    nameController.clear();
    locationController.clear();
    serviceSelectorKey.currentState?.reset();
    brandSelectorKey.currentState?.reset();
  }

  void _initControllers() {
    nameController.addListener(() {});
  }
}
