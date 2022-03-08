import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techfrenetic/app/common/validators.dart';

class ProfileBloc extends Disposable {
  final _nameController = BehaviorSubject<String>();
  final _professionController = BehaviorSubject<String>();

  Stream<String> get nameStream =>
      _nameController.stream.transform(Validators.validateName);
  Stream<String> get professionStream =>
      _professionController.stream.transform(Validators.validateProfession);
  Stream<bool> get nameFormStream => Rx.combineLatest2(_nameController,
      _professionController, (nameStream, professionStream) => true);

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeProfession => _professionController.sink.add;

  String? get name => _nameController.valueOrNull;
  String? get profession => _professionController.valueOrNull;

  @override
  void dispose() {
    _nameController.close();
    _professionController.close();
  }
}
