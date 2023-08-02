import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:techfrenetic/app/models/dtos/paginator_dto.dart';
import 'package:techfrenetic/app/models/dtos/vendor_filter_dto.dart';
import 'package:techfrenetic/app/models/vendor_model.dart';
import 'package:techfrenetic/app/providers/vendors_provider.dart';

import '../../models/vendor_description.dart';

part 'vendors_store.g.dart';

class VendorsStore = _VendorsStoreBase with _$VendorsStore;

enum VendorDescriptionStoreState { initial, loading, loaded, error }

enum RecentVendorsStoreState { initial, loading, loaded, error }

enum SearchVendorsStoreState { initial, loading, loaded, error }

abstract class _VendorsStoreBase with Store {
  final _vendorsProvider = Modular.get<VendorsProvider>();

  @observable
  ObservableFuture<VendorDescriptionModel>? _vendorsDescriptionFuture;

  @observable
  ObservableFuture<PaginatorDto<VendorModel>>? _recentVendorsFuture;

  @observable
  ObservableFuture<PaginatorDto<VendorModel>>? _vendorsFuture;

  @observable
  ObservableList<VendorModel> vendors = ObservableList.of([]);

  @observable
  ObservableList<VendorModel> recentVendors = ObservableList.of([]);

  @observable
  VendorDescriptionModel? description;

  @observable
  int currentPage = 0;

  @observable
  String? name;

  @observable
  String? location;

  @observable
  String? area;

  @observable
  String? brand;

  @observable
  bool? hasErrors;

  _VendorsStoreBase() {
    loadDescription();
    loadRecentVendors();
  }

  @action
  setArea(String value) {
    area = value;
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
  setBrand(String value) {
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
        ObservableFuture(_vendorsProvider.getRecentVendors(page: currentPage));
    recentVendors = ObservableList.of((await _recentVendorsFuture!).items);
  }

  @action
  Future<void> searchVendors() async {
    var _filter = VendorFilterDto(
        name: name, brand: brand, area: area, location: location);
    _vendorsFuture = ObservableFuture(_vendorsProvider.searchVendors(
      page: currentPage,
      filter: _filter,
    ));
    vendors = ObservableList.of((await _recentVendorsFuture!).items);
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
}
