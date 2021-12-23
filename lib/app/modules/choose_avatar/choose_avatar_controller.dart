import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import '../../common/validators.dart';

class ChooseAvatarController extends Disposable {
  final _avatarController = BehaviorSubject<bool>();

  Stream<bool> get avatarStream =>
      _avatarController.stream.transform(Validators.validateTerms);

  Function(bool) get changeaAvatar => _avatarController.sink.add;

  bool get terms => _avatarController.value;

  Future<bool> chooseAvatar() async {
    debugPrint('Sing in');
    return true;
  }

  @override
  void dispose() {
    _avatarController.close();
  }
}
