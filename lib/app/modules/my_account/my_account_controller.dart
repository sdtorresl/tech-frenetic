import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techfrenetic/app/core/user_preferences.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';
import '../../common/validators.dart';

class MyAccountController extends Disposable {
  final _emailController = BehaviorSubject<String>();
  final _cellphoneController = BehaviorSubject<String>();
  final _countryController = BehaviorSubject<String>();
  final _birthdateController = BehaviorSubject<DateTime>();

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

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeCountry => _countryController.sink.add;
  Function(String) get changeCellphone => _cellphoneController.sink.add;
  Function(DateTime) get changeBirthdate => _birthdateController.sink.add;

  String get email => _emailController.valueOrNull ?? "";
  String? get country => _countryController.valueOrNull;
  String get cellphone => _cellphoneController.valueOrNull ?? "";
  DateTime? get birthdate => _birthdateController.valueOrNull;

  Future<bool> update() async {
    UserPreferences prefs = UserPreferences();
    UserProvider _userProvider = UserProvider();

    prefs.userEmail = email;
    prefs.userBirthdate = birthdate;
    prefs.userCountry = country;
    prefs.userPhone = cellphone;

    return await _userProvider.userUpdate(
        birthdate!, cellphone, country!, email);
  }

  @override
  void dispose() {
    _emailController.close();
    _countryController.close();
    _cellphoneController.close();
    _birthdateController.close();
  }
}
