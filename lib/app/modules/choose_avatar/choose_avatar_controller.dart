import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import '../../common/validators.dart';

class ChooseAvatarController extends Disposable {
  final _termsController = BehaviorSubject<bool>();

  Stream<bool> get termsStream =>
      _termsController.stream.transform(Validators.validateTerms);

  Function(bool) get changeTerms => _termsController.sink.add;

  bool get terms => _termsController.value;

  Future<bool> sing() async {
    debugPrint('Sing in');
    return true;
  }

  @override
  void dispose() {
    _termsController.close();
  }
}
