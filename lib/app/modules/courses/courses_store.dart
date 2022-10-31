import 'package:mobx/mobx.dart';

part 'courses_store.g.dart';

class CoursesStore = _CoursesStoreBase with _$CoursesStore;
abstract class _CoursesStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}