// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatStore on _ChatStoreBase, Store {
  late final _$loadingAtom =
      Atom(name: '_ChatStoreBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$messageEditingControllerAtom =
      Atom(name: '_ChatStoreBase.messageEditingController', context: context);

  @override
  TextEditingController get messageEditingController {
    _$messageEditingControllerAtom.reportRead();
    return super.messageEditingController;
  }

  @override
  set messageEditingController(TextEditingController value) {
    _$messageEditingControllerAtom
        .reportWrite(value, super.messageEditingController, () {
      super.messageEditingController = value;
    });
  }

  late final _$filterEditingControllerAtom =
      Atom(name: '_ChatStoreBase.filterEditingController', context: context);

  @override
  TextEditingController get filterEditingController {
    _$filterEditingControllerAtom.reportRead();
    return super.filterEditingController;
  }

  @override
  set filterEditingController(TextEditingController value) {
    _$filterEditingControllerAtom
        .reportWrite(value, super.filterEditingController, () {
      super.filterEditingController = value;
    });
  }

  late final _$loggedUserAtom =
      Atom(name: '_ChatStoreBase.loggedUser', context: context);

  @override
  User? get loggedUser {
    _$loggedUserAtom.reportRead();
    return super.loggedUser;
  }

  @override
  set loggedUser(User? value) {
    _$loggedUserAtom.reportWrite(value, super.loggedUser, () {
      super.loggedUser = value;
    });
  }

  late final _$usersAtom = Atom(name: '_ChatStoreBase.users', context: context);

  @override
  ObservableList<User> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(ObservableList<User> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  late final _$conversationsAtom =
      Atom(name: '_ChatStoreBase.conversations', context: context);

  @override
  ObservableList<Conversation> get conversations {
    _$conversationsAtom.reportRead();
    return super.conversations;
  }

  @override
  set conversations(ObservableList<Conversation> value) {
    _$conversationsAtom.reportWrite(value, super.conversations, () {
      super.conversations = value;
    });
  }

  late final _$groupsAtom =
      Atom(name: '_ChatStoreBase.groups', context: context);

  @override
  ObservableList<Group> get groups {
    _$groupsAtom.reportRead();
    return super.groups;
  }

  @override
  set groups(ObservableList<Group> value) {
    _$groupsAtom.reportWrite(value, super.groups, () {
      super.groups = value;
    });
  }

  late final _$messagesAtom =
      Atom(name: '_ChatStoreBase.messages', context: context);

  @override
  ObservableList<BaseMessage> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(ObservableList<BaseMessage> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  @override
  String toString() {
    return '''
loading: ${loading},
messageEditingController: ${messageEditingController},
filterEditingController: ${filterEditingController},
loggedUser: ${loggedUser},
users: ${users},
conversations: ${conversations},
groups: ${groups},
messages: ${messages}
    ''';
  }
}
