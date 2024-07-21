import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techfrenetic/app/models/group_user_model.dart';
import 'package:techfrenetic/app/models/image_model.dart';
import 'package:techfrenetic/app/providers/group_providers.dart';
import 'package:techfrenetic/app/providers/notifications_provider.dart';
import '../../common/validators.dart';
import '../../models/enums/notification_type_enum.dart';

class CreateGroupsController extends Disposable {
  final _nameController = BehaviorSubject<String>();
  final _descriptionController = BehaviorSubject<String>();
  final _rulesController = BehaviorSubject<String>();
  final _membersController =
      BehaviorSubject<Iterable<GroupUserModel>>.seeded([]);
  final _isPublicController = BehaviorSubject<bool>();
  final _imageController = BehaviorSubject<ImageModel>();

  Stream<String> get nameStream =>
      _nameController.stream.transform(Validators.validateName);
  Stream<String> get descriptionStream =>
      _descriptionController.stream.transform(Validators.validateName);
  Stream<String> get rulesStream =>
      _rulesController.stream.transform(Validators.validateName);
  Stream<Iterable<GroupUserModel>> get namePersonStream =>
      _membersController.stream;
  Stream<bool> get isPublicStream => _isPublicController;
  Stream<ImageModel> get imageStream => _imageController;

  Stream<bool> get formValidStream => Rx.combineLatest5(
      nameStream,
      descriptionStream,
      rulesStream,
      namePersonStream,
      imageStream,
      (name, desc, rules, people, image) => true);

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeDescription => _descriptionController.sink.add;
  Function(String) get changeRules => _rulesController.sink.add;
  Function(GroupUserModel) get addMember => (GroupUserModel member) {
        List<GroupUserModel> newMembers = List.from(members);
        if (!newMembers.contains(member)) {
          newMembers.add(member);
          _membersController.sink.add(newMembers);
        }
      };
  Function(GroupUserModel) get removeMember => (GroupUserModel member) {
        List<GroupUserModel> newMembers = List.from(members);
        newMembers.removeWhere((item) => item == member);
        _membersController.sink.add(newMembers);
      };
  Function(bool) get changeType => _isPublicController.sink.add;
  Function(ImageModel) get changeImage => _imageController.sink.add;

  String get name => _nameController.value;
  String get description => _descriptionController.value;
  String get rules => _rulesController.value;
  Iterable<GroupUserModel> get members => _membersController.value;
  bool get isPublic => _isPublicController.value;
  ImageModel get image => _imageController.value;

  Future<bool> createGroup() async {
    GroupsProvider _groupProvider = GroupsProvider();
    NotificationsProvider _notificationsProvider = NotificationsProvider();

    bool created = await _groupProvider.createGroup(
        name, description, rules, isPublic, image);

    if (created) {
      _notificationsProvider.postNotification(
        type: NotificationType.group,
        targetId: 15, // TODO; Use group ID
      );
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
    _membersController.close();
    _isPublicController.close();
  }
}
