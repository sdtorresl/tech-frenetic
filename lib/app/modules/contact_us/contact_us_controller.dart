import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import '../../common/validators.dart';

class ContactUsController extends Disposable {
  final _emailController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();
  final _descriptionController = BehaviorSubject<String>();
  final _termsController = BehaviorSubject<bool>();

  Stream<String> get nameStream =>
      _nameController.stream.transform(Validators.validateName);
  Stream<String> get emailStream =>
      _emailController.stream.transform(Validators.validateEmail);
  Stream<String> get descriptionStream =>
      _descriptionController.stream.transform(Validators.validateName);
  Stream<bool> get termsStream =>
      _termsController.stream.transform(Validators.validateTerms);

  Stream<bool> get formValidStream => Rx.combineLatest4(nameStream, emailStream,
      descriptionStream, termsStream, (e, p, c, a) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeDescription => _descriptionController.sink.add;
  Function(bool) get changeTerms => _termsController.sink.add;

  String get email => _emailController.value;
  String get name => _nameController.value;
  String get description => _descriptionController.value;
  bool get terms => _termsController.value;

  Future<bool> contactUs() async {
    debugPrint('The contact email was send');
    return true;
  }

  @override
  void dispose() {
    _emailController.close();
    _descriptionController.close();
    _nameController.close();
    _termsController.close();
  }
}
