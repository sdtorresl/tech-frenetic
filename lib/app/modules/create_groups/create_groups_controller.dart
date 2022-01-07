import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techfrenetic/app/providers/create_group_provider.dart';
import '../../common/validators.dart';

class CreateGroupsController extends Disposable {
  final _nameController = BehaviorSubject<String>();
  final _descriptionController = BehaviorSubject<String>();
  final _rulesController = BehaviorSubject<String>();
  final _namePersonController = BehaviorSubject<String>();
  final _typeController = BehaviorSubject<String>();

  Stream<String> get nameStream =>
      _nameController.stream.transform(Validators.validateName);
  Stream<String> get descriptionStream =>
      _descriptionController.stream.transform(Validators.validateName);
  Stream<String> get rulesStream =>
      _rulesController.stream.transform(Validators.validateName);
  Stream<String> get namePersonStream =>
      _namePersonController.stream.transform(Validators.validateName);
  Stream<String> get typeStream =>
      _typeController.stream.transform(Validators.validateName);

  Stream<bool> get formValidStream => Rx.combineLatest4(nameStream,
      descriptionStream, rulesStream, namePersonStream, (e, p, a, b) => true);

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeDescription => _descriptionController.sink.add;
  Function(String) get changeRules => _rulesController.sink.add;
  Function(String) get changeNamePerson => _namePersonController.sink.add;
  Function(String) get changeType => _typeController.sink.add;

  String get name => _nameController.value;
  String get description => _descriptionController.value;
  String get rules => _rulesController.value;
  String get namePerson => _namePersonController.value;
  String get type => _typeController.value;

  Future<bool> createGroup() async {
    CreateGroupProvider _createGroupProvider = CreateGroupProvider();

    bool? create = await _createGroupProvider.createGroup(
        name, description, rules, namePerson, type);

    if (create == true) {
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
    _typeController.close();
  }
}
