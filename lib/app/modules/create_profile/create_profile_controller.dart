import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import '../../common/validators.dart';

class CreateProfileController extends Disposable {
  final _nameController = BehaviorSubject<String>();
  final _descriptionController = BehaviorSubject<String>();

  Stream<String> get nameStream =>
      _nameController.stream.transform(Validators.validateName);

  Stream<String> get descriptionStream =>
      _descriptionController.stream.transform(Validators.validateName);

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(nameStream, descriptionStream, (e, p) => true);

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeDescription => _descriptionController.sink.add;

  String get name => _nameController.value;
  String get description => _descriptionController.value;

  Future<bool> createProfile() async {
    debugPrint('Profile not created');
    return true;
  }

  @override
  void dispose() {
    _descriptionController.close();
    _nameController.close();
  }
}
