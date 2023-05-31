import 'package:mobx/mobx.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStoreBase with _$ProfileStore;

abstract class _ProfileStoreBase with Store {
  @observable
  int index = 0;

  @observable
  int following = 0;

  @observable
  int followers = 0;
}
