import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techfrenetic/app/core/user_preferences.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';

import '../../../common/validators.dart';

class MyAccountController extends Disposable {
  final UserPreferences _prefs = UserPreferences();
  final UserProvider _userProvider = UserProvider();

  final _emailController = BehaviorSubject<String>();
  final _cellphoneController = BehaviorSubject<String>();
  final _countryController = BehaviorSubject<String>();
  final _birthdateController = BehaviorSubject<DateTime>();
  final _tokenController = BehaviorSubject<String>();
  final _newPasswordController = BehaviorSubject<String>();
  final _passwordConfirmationController = BehaviorSubject<bool>();

  Stream<String> get emailStream =>
      _emailController.stream.transform(Validators.validateEmail);
  Stream<String> get countryStream =>
      _countryController.stream.transform(Validators.validateName);
  Stream<String> get cellphoneStream =>
      _cellphoneController.stream.transform(Validators.validateName);
  Stream<DateTime> get birthdateStream =>
      _birthdateController.stream.transform(Validators.validateDate);
  Stream<bool> get formValidStream => Rx.combineLatest3(
      emailStream, cellphoneStream, birthdateStream, (e, p, c) => true);
  Stream<String> get tokenStream => _tokenController.stream;
  Stream<String> get newPasswordStream => _newPasswordController.stream
      .transform(Validators.validateSignInPassword);
  Stream<bool> get passwordConfirmationStream =>
      _passwordConfirmationController.stream
          .transform(Validators.validateConfirmPass);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeCountry => _countryController.sink.add;
  Function(String) get changeCellphone => _cellphoneController.sink.add;
  Function(DateTime) get changeBirthdate => _birthdateController.sink.add;
  Function(String) get changeToken => _tokenController.sink.add;
  Function(String) get changeNewPassword => _newPasswordController.sink.add;
  Function(bool) get changeNewConfirmationPassword =>
      _passwordConfirmationController.sink.add;

  String get email => _emailController.valueOrNull ?? "";
  String? get country => _countryController.valueOrNull;
  String get cellphone => _cellphoneController.valueOrNull ?? "";
  DateTime? get birthdate => _birthdateController.valueOrNull;
  String get token => _tokenController.valueOrNull ?? "";
  String get newPassword => _newPasswordController.valueOrNull ?? "";
  bool get newConfirmationPassword =>
      _passwordConfirmationController.valueOrNull ?? false;

  Future<bool> update() async {
    _prefs.userEmail = email;
    _prefs.userBirthdate = birthdate;
    _prefs.userCountry = country;
    _prefs.userPhone = cellphone;

    return await _userProvider.userUpdate(
      birthdate,
      cellphone,
      country,
      email,
    );
  }

  @override
  void dispose() {
    debugPrint("Disposed!!!");
    _emailController.close();
    _countryController.close();
    _cellphoneController.close();
    _birthdateController.close();
  }

  Future<bool> updatePassword() {
    return _userProvider.updateLoggedUserPassword(token, newPassword);
  }
}
