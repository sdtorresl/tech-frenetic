// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messaging_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MessagingStore on _ChatStoreBase, Store {
  late final _$activeUidAtom =
      Atom(name: '_ChatStoreBase.activeUid', context: context);

  @override
  String? get activeUid {
    _$activeUidAtom.reportRead();
    return super.activeUid;
  }

  @override
  set activeUid(String? value) {
    _$activeUidAtom.reportWrite(value, super.activeUid, () {
      super.activeUid = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_ChatStoreBase.status', context: context);

  @override
  String? get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(String? value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

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

  late final _$getMessagesAsyncAction =
      AsyncAction('_ChatStoreBase.getMessages', context: context);

  @override
  Future<void> getMessages(AppEntity entity) {
    return _$getMessagesAsyncAction.run(() => super.getMessages(entity));
  }

  late final _$_ChatStoreBaseActionController =
      ActionController(name: '_ChatStoreBase', context: context);

  @override
  void addMessage(BaseMessage message) {
    final _$actionInfo = _$_ChatStoreBaseActionController.startAction(
        name: '_ChatStoreBase.addMessage');
    try {
      return super.addMessage(message);
    } finally {
      _$_ChatStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$_ChatStoreBaseActionController.startAction(
        name: '_ChatStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_ChatStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
activeUid: ${activeUid},
status: ${status},
loading: ${loading},
messageEditingController: ${messageEditingController},
messages: ${messages}
    ''';
  }
}
