import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techfrenetic/app/providers/group_providers.dart';
import '../../common/validators.dart';

class CreateGroupsController extends Disposable {
  final _nameController = BehaviorSubject<String>();
  final _descriptionController = BehaviorSubject<String>();
  final _rulesController = BehaviorSubject<String>();
  final _namePersonController = BehaviorSubject<String>();
  final _isPublicController = BehaviorSubject<bool>();

  Stream<String> get nameStream =>
      _nameController.stream.transform(Validators.validateName);
  Stream<String> get descriptionStream =>
      _descriptionController.stream.transform(Validators.validateName);
  Stream<String> get rulesStream =>
      _rulesController.stream.transform(Validators.validateName);
  Stream<String> get namePersonStream =>
      _namePersonController.stream.transform(Validators.validateName);
  Stream<bool> get isPublicStream => _isPublicController;

  Stream<bool> get formValidStream => Rx.combineLatest4(nameStream,
      descriptionStream, rulesStream, namePersonStream, (e, p, a, b) => true);

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeDescription => _descriptionController.sink.add;
  Function(String) get changeRules => _rulesController.sink.add;
  Function(String) get changeNamePerson => _namePersonController.sink.add;
  Function(bool) get changeType => _isPublicController.sink.add;

  String get name => _nameController.value;
  String get description => _descriptionController.value;
  String get rules => _rulesController.value;
  String get namePerson => _namePersonController.value;
  bool get isPublic => _isPublicController.value;

  Future<bool> createGroup() async {
    GroupsProvider _createGroupProvider = GroupsProvider();

    bool created = await _createGroupProvider.createGroup(
        name, description, rules, isPublic);

    if (created) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _nameController.close();
    _descriptionController.close();
    _rulesController.close();
    _namePersonController.close();
    _isPublicController.close();
  }
}
