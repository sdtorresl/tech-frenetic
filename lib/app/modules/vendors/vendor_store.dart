import 'package:mobx/mobx.dart';

part 'vendor_store.g.dart';

class VendorStore = _VendorStoreBase with _$VendorStore;
abstract class _VendorStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}