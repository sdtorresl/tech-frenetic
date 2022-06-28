import 'package:mobx/mobx.dart';
import 'package:techfrenetic/app/models/user_model.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStoreBase with _$ProfileStore;

abstract class _ProfileStoreBase with Store {
  @observable
  int index = 0;

  @observable
  UserModel _loggedUser = UserModel.empty();

  set loggedUser(UserModel user) {
    _loggedUser = user;
  }

  @computed
  UserModel get loggedUser => _loggedUser;
}
