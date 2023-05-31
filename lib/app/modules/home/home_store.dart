import 'package:mobx/mobx.dart';
import 'package:techfrenetic/app/models/user_model.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  @observable
  int selectedPage = 0;

  @observable
  UserModel? loggedUser;
}
