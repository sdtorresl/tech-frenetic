import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../providers/user_provider.dart';

part 'courses_store.g.dart';

class CoursesStore = _CoursesStoreBase with _$CoursesStore;

abstract class _CoursesStoreBase with Store {
  @observable
  bool isLoading = false;

  @observable
  bool isPremium = false;

  final UserProvider _userProvider = Modular.get();

  Future<void> checkIfPremium() async {
    isLoading = true;
    isPremium = await _userProvider.isPremium();
    isLoading = false;
  }
}
