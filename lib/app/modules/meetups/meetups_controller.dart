import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techfrenetic/app/providers/meetups_provider.dart';
import '../../common/validators.dart';

class MeetupsController extends Disposable {
  final _urlController = BehaviorSubject<String>();
  final _dateController = BehaviorSubject<DateTime>();
  final _locationController = BehaviorSubject<String>();
  final _titleController = BehaviorSubject<String>();

  Stream<String> get urlStream =>
      _urlController.stream.transform(Validators.validateUrl);

  Stream<DateTime> get dateStream =>
      _dateController.stream.transform(Validators.validateDateMeetups);

  Stream<String> get locationStream =>
      _locationController.stream.transform(Validators.validateFieldRequired);

  Stream<String> get titleStream =>
      _titleController.stream.transform(Validators.validateFieldRequired);

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
    MeetupsProvider _meetupsProvider = MeetupsProvider();

    bool? createMeetup =
        await _meetupsProvider.createMeetup(url, date, location, title);
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
