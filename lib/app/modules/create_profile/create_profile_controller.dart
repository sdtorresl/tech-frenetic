import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techfrenetic/app/providers/registration_provider.dart';
import '../../common/validators.dart';

class CreateProfileController extends Disposable {
  final _companynameController = BehaviorSubject<String>();
  final _professionController = BehaviorSubject<String>();
  final _countryController = BehaviorSubject<String>();
  final _descriptionController = BehaviorSubject<String>();

  Stream<String> get companynameStream =>
      _companynameController.stream.transform(Validators.validateName);

  Stream<String> get professionStream =>
      _professionController.stream.transform(Validators.validateName);

  Stream<String> get countryStream =>
      _countryController.stream.transform(Validators.validateName);

  Stream<String> get descriptionStream =>
      _descriptionController.stream.transform(Validators.validateName);

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(companynameStream, descriptionStream, (e, p) => true);

  Function(String) get changeCompanyName => _companynameController.sink.add;
  Function(String) get changeProfession => _professionController.sink.add;
  Function(String) get changeCountry => _countryController.sink.add;
  Function(String) get changeDescription => _descriptionController.sink.add;

  String get companyName => _companynameController.value;
  String get profession => _professionController.value;
  String get country => _countryController.value;
  String get description => _descriptionController.value;

  Future<bool> createProfile() async {
    RegistrationProvider _registrationProvider = RegistrationProvider();
    bool profile = await _registrationProvider.createProfile(
        companyName, profession, country, description);
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
  }
}
