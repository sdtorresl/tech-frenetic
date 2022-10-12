import 'package:mobx/mobx.dart';
import 'package:techfrenetic/app/models/notification_model.dart';

part 'notifications_store.g.dart';

class NotificationsStore = _NotificationsStoreBase with _$NotificationsStore;

abstract class _NotificationsStoreBase with Store {
  @observable
  ObservableList<NotificationModel> selectedNotifications =
      ObservableList<NotificationModel>();

  @action
  clearNotifications() {
    selectedNotifications.clear();
  }

  @action
  addNotification(NotificationModel notification) {
    selectedNotifications.add(notification);
  }

  @action
  removeNotification(NotificationModel notification) {
    selectedNotifications.remove(notification);
  }
}
