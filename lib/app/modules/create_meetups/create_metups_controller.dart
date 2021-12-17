import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import '../../common/validators.dart';

class CreateMeetupsController extends Disposable {
  final _cityController = BehaviorSubject<String>();
  final _descriptionController = BehaviorSubject<String>();

  Stream<String> get cityStream =>
      _cityController.stream.transform(Validators.validateName);

  Stream<String> get descriptionStream =>
      _descriptionController.stream.transform(Validators.validateName);

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(cityStream, descriptionStream, (e, p) => true);

  Function(String) get changeName => _cityController.sink.add;
  Function(String) get changeDescription => _descriptionController.sink.add;

  String get name => _cityController.value;
  String get description => _descriptionController.value;

  Future<bool> createMeetups() async {
    debugPrint('Meetup created');
    return true;
  }

  @override
  void dispose() {
    _cityController.close();
    _descriptionController.close();
  }
}
