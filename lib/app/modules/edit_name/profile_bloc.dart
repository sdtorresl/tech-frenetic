import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techfrenetic/app/common/validators.dart';

class ProfileBloc extends Disposable {
  final _nameController = BehaviorSubject<String>.seeded("");
  final _professionController = BehaviorSubject<String>.seeded("");

  Stream<String> get nameStream =>
      _nameController.stream.transform(Validators.validateName);
  Stream<String> get professionStream =>
      _professionController.stream.transform(Validators.validateProfession);

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeProfession => _professionController.sink.add;

  String get name => _nameController.value;
  String get profession => _professionController.value;

  @override
  void dispose() {
    _nameController.close();
    _professionController.close();
  }
}
