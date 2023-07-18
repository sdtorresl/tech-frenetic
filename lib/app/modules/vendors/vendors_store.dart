import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:techfrenetic/app/models/dtos/paginator_dto.dart';
import 'package:techfrenetic/app/models/vendor_model.dart';
import 'package:techfrenetic/app/providers/vendors_provider.dart';

part 'vendors_store.g.dart';

class VendorsStore = _VendorsStoreBase with _$VendorsStore;

enum VendorsStoreState { initial, loading, loaded, error }

abstract class _VendorsStoreBase with Store {
  final _vendorsProvider = Modular.get<VendorsProvider>();

  @observable
  ObservableFuture<PaginatorDto<VendorModel>>? _recentVendorsFuture;

  @observable
  List<VendorModel> recentVendors = [];

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
  Future<void> loadRecentVendors() async {
    _recentVendorsFuture =
        ObservableFuture(_vendorsProvider.getRecentVendors(page: currentPage));
    recentVendors = ObservableList.of((await _recentVendorsFuture!).items);
  }

  @computed
  VendorsStoreState get recentVendorsState {
    if (_recentVendorsFuture == null) {
      return VendorsStoreState.initial;
    }

    switch (_recentVendorsFuture!.status) {
      case FutureStatus.pending:
        return VendorsStoreState.loading;
      case FutureStatus.fulfilled:
        return VendorsStoreState.loaded;
      case FutureStatus.rejected:
        return VendorsStoreState.error;
      default:
        return VendorsStoreState.initial;
    }
  }

  @action
  void search() {}
}
