// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotificationsStore on _NotificationsStoreBase, Store {
  late final _$selectedNotificationsAtom = Atom(
      name: '_NotificationsStoreBase.selectedNotifications', context: context);

  @override
  ObservableList<NotificationModel> get selectedNotifications {
    _$selectedNotificationsAtom.reportRead();
    return super.selectedNotifications;
  }

  @override
  set selectedNotifications(ObservableList<NotificationModel> value) {
    _$selectedNotificationsAtom.reportWrite(value, super.selectedNotifications,
        () {
      super.selectedNotifications = value;
    });
  }

  late final _$_NotificationsStoreBaseActionController =
      ActionController(name: '_NotificationsStoreBase', context: context);

  @override
  dynamic clearNotifications() {
    final _$actionInfo = _$_NotificationsStoreBaseActionController.startAction(
        name: '_NotificationsStoreBase.clearNotifications');
    try {
      return super.clearNotifications();
    } finally {
      _$_NotificationsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addNotification(NotificationModel notification) {
    final _$actionInfo = _$_NotificationsStoreBaseActionController.startAction(
        name: '_NotificationsStoreBase.addNotification');
    try {
      return super.addNotification(notification);
    } finally {
      _$_NotificationsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeNotification(NotificationModel notification) {
    final _$actionInfo = _$_NotificationsStoreBaseActionController.startAction(
        name: '_NotificationsStoreBase.removeNotification');
    try {
      return super.removeNotification(notification);
    } finally {
      _$_NotificationsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedNotifications: ${selectedNotifications}
    ''';
  }
}
