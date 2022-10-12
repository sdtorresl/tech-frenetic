import 'package:mobx/mobx.dart';
import 'package:techfrenetic/app/models/user_model.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStoreBase with _$ProfileStore;

abstract class _ProfileStoreBase with Store {
  @observable
  int index = 0;

  @observable
  UserModel? loggedUser;

  @observable
  int following = 0;

  @observable
  int followers = 0;
}
