import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techfrenetic/app/providers/create_meeetup_provider.dart';
import '../../common/validators.dart';

class CreateMeetupsController extends Disposable {
  final _urlController = BehaviorSubject<String>();
  final _dateController = BehaviorSubject<DateTime>();
  final _locationController = BehaviorSubject<String>();
  final _titleController = BehaviorSubject<String>();

  Stream<String> get urlStream =>
      _urlController.stream.transform(Validators.validateUrl);

  Stream<DateTime> get dateStream =>
      _dateController.stream.transform(Validators.validateDate);

  Stream<String> get locationStream =>
      _locationController.stream.transform(Validators.validateName);

  Stream<String> get titleStream =>
      _titleController.stream.transform(Validators.validateName);

  Stream<bool> get formValidStream => Rx.combineLatest4(
      urlStream, dateStream, locationStream, titleStream, (e, p, a, c) => true);

  Function(String) get changeUrl => _urlController.sink.add;
  Function(DateTime) get changeDate => _dateController.sink.add;
  Function(String) get changeLocation => _locationController.sink.add;
  Function(String) get changeTitle => _titleController.sink.add;

  String get url => _urlController.value;
  DateTime get date => _dateController.value;
  String get location => _locationController.value;
  String get title => _titleController.value;

  Future<bool> createMeetups() async {
    CreateMeetupProvider _createMeetupPorovider = CreateMeetupProvider();

    bool? createMeetup =
        await _createMeetupPorovider.createMeetup(url, date, location, title);
    if (createMeetup == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _urlController.close();
    _dateController.close();
    _dateController.close();
    _titleController.close();
  }
}
