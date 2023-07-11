import 'package:mobx/mobx.dart';

part 'vendors_store.g.dart';

class VendorsStore = _VendorsStoreBase with _$VendorsStore;
abstract class _VendorsStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}