import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import '../../common/validators.dart';

class SignUpController extends Disposable {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();
  final _termsController = BehaviorSubject<bool>();

  //final _confirmPasswordController = BehaviorSubject<List<String>>();

  Stream<String> get emailStream =>
      _emailController.stream.transform(Validators.validateEmail);

  Stream<String> get passwordStream =>
      _passwordController.stream.transform(Validators.validatePassword);

  Stream<String> get nameStream =>
      _nameController.stream.transform(Validators.validateName);

  Stream<bool> get termsStream =>
      _termsController.stream.transform(Validators.validateTerms);

  // Stream<List<String>> get confirmPasswordStream =>
  //     _confirmPasswordController.stream.transform(Validators.validateConfirmPasword);

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeName => _nameController.sink.add;
  Function(bool) get changeTerms => _termsController.sink.add;
  //Function(String) get changeConfirmPassword => _confirmPasswordController.sink.add;

  String get email => _emailController.value;
  String get password => _passwordController.value;

  Future<bool?> sing() async {
    debugPrint('Pressed');
  }

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
