import 'dart:math';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techfrenetic/app/models/session_model.dart';
import 'package:techfrenetic/app/providers/registration_provider.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';
import '../../common/validators.dart';

class SignUpController extends Disposable {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();
  final _userTypeontroller = BehaviorSubject<String>.seeded('person');
  final _termsController = BehaviorSubject<bool>.seeded(false);

  Stream<String> get emailStream =>
      _emailController.stream.transform(Validators.validateEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(Validators.validateSignInPassword);
  Stream<String> get nameStream =>
      _nameController.stream.transform(Validators.validateName);
  Stream<String> get userTypeStream =>
      _userTypeontroller.stream.transform(Validators.validateName);
  Stream<bool> get termsStream =>
      _termsController.stream.transform(Validators.validateTerms);
  Stream<bool> get formValidStream => Rx.combineLatest4(termsStream, nameStream,
      emailStream, passwordStream, (e, p, c, d) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeUserType => _userTypeontroller.sink.add;
  Function(bool) get changeTerms => _termsController.sink.add;

  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get name => _nameController.value;
  String get userType => _userTypeontroller.value;
  bool get terms => _termsController.value;

  Future<String> sign() async {
    List<String> emailSplit = email.split('@');
    Random randomNumber = Random();
    String? userName = emailSplit[0] + randomNumber.nextInt(1000).toString();
    RegistrationProvider _registrationProvider = RegistrationProvider();
    UserProvider _userProvider = UserProvider();

    String? session = await _registrationProvider.signUp(
        userName, email, password, name, userType);

    if (session == userName) {
      Random randomNumber = Random();
      userName = emailSplit[0] + randomNumber.nextInt(1000).toString();
      String? session = await _registrationProvider.signUp(
          userName, email, password, name, userType);
      if (session == email) {
        return 'alredy use email';
      }
      if (session == 'true') {
        SessionModel? login = await _userProvider.login(email, password);
        if (login != null) {
          return 'true';
        } else {
          return 'false';
        }
      } else {
        return 'false';
      }
    }
    if (session == email) {
      return 'alredy use email';
    }

    if (session == 'true') {
      SessionModel? login = await _userProvider.login(email, password);
      if (login != null) {
        return 'true';
      } else {
        return 'false';
      }
    } else {
      return 'false';
    }
  }

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    _nameController.close();
    _userTypeontroller.close();
    _termsController.close();
  }
}
