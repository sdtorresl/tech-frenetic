import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techfrenetic/app/common/validators.dart';
import 'package:techfrenetic/app/providers/registration_provider.dart';

class CreateProfileController extends Disposable {
  final RegistrationProvider _registrationProvider = RegistrationProvider();

  final _companynameController = BehaviorSubject<String>();
  final _professionController = BehaviorSubject<String>();
  final _countryController = BehaviorSubject<String>();
  final _descriptionController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _codeController = BehaviorSubject<String>();
  final _verificationController = BehaviorSubject<String?>();
  final _genreController = BehaviorSubject<String>();
  final _birthdateController = BehaviorSubject<DateTime>();

  Stream<String> get companynameStream =>
      _companynameController.stream.transform(Validators.validateName);
  Stream<String> get professionStream =>
      _professionController.stream.transform(Validators.validateName);
  Stream<String> get countryStream =>
      _countryController.stream.transform(Validators.validateName);
  Stream<String> get descriptionStream =>
      _descriptionController.stream.transform(Validators.validateName);
  Stream<String> get phoneStream => _phoneController.stream;
  Stream<String> get genreStream => _genreController.stream;
  Stream<DateTime> get birthdateStream =>
      _birthdateController.stream.transform(Validators.validateDate);
  Stream<String> get codeStream =>
      _codeController.stream.transform(Validators.validateCode);

  Stream<bool> get formValidStream => Rx.combineLatest5(
      companynameStream,
      descriptionStream,
      phoneStream,
      genreStream,
      birthdateStream,
      (c, d, p, g, b) => true);

  Stream<bool> get submitValidStream =>
      Rx.combineLatest2(formValidStream, codeStream, (f, c) => true);

  Function(String) get changeCompanyName => _companynameController.sink.add;
  Function(String) get changeProfession => _professionController.sink.add;
  Function(String) get changeCountry => _countryController.sink.add;
  Function(String) get changeDescription => _descriptionController.sink.add;
  Function(String) get changePhone => _phoneController.sink.add;
  Function(String) get changeGenre => _genreController.sink.add;
  Function(String) get changeVerificationId => _verificationController.sink.add;
  Function(DateTime) get changeBirthdate => _birthdateController.sink.add;
  Function(String) get changeCode => _codeController.sink.add;

  String get companyName => _companynameController.value;
  String get profession => _professionController.value;
  String get country => _countryController.value;
  String get description => _descriptionController.value;
  String? get phone => _phoneController.valueOrNull;
  String? get genre => _genreController.valueOrNull;
  String? get verificationId => _verificationController.valueOrNull;
  DateTime get birthdate => _birthdateController.value;
  String? get code => _codeController.valueOrNull;

  Future<bool> validateCode() async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: code.toString(),
      ));
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }

    return true;
  }

  Future<bool> createProfile() async {
    bool? profile = await _registrationProvider.createProfile(
        companyName, profession, country, description, phone, genre, birthdate);
    if (profile == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _companynameController.close();
    _professionController.close();
    _countryController.close();
    _descriptionController.close();
    _genreController.close();
    _birthdateController.close();
    _phoneController.close();
  }
}
