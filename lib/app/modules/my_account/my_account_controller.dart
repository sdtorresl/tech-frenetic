import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techfrenetic/app/providers/user_actualizations_provider.dart';
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

  String get email => _emailController.value;
  String get country => _countryController.value;
  String get cellphone => _cellphoneController.value;
  DateTime get birthdate => _birthdateController.value;

  Future<bool> update() async {
    UserActualizationsProvider _actualizationsProvider =
        UserActualizationsProvider();

    bool? update = await _actualizationsProvider.userUpdate(
        birthdate, cellphone, country, email);

    if (update == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.close();
    _countryController.close();
    _cellphoneController.close();
    _birthdateController.close();
  }
}
