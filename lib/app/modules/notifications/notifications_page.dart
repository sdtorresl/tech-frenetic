import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/models/notification_model.dart';
import 'package:techfrenetic/app/modules/notifications/notifications_store.dart';
import 'package:techfrenetic/app/providers/notifications_provider.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final NotificationsStore store = Modular.get();
  final NotificationsProvider _notificationsProvider = NotificationsProvider();
  List<NotificationModel> _notifications = List<NotificationModel>.empty();
  bool isLoading = false;

  @override
  void initState() {
    store.clearNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TFAppBar(
        title: Text(
          AppLocalizations.of(context)!.profile_notifications,
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Theme.of(context).primaryColor),
        ),
        actions: [
          Observer(
            builder: (BuildContext context) {
              return store.selectedNotifications.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Badge(
                        badgeContent: Text(
                          store.selectedNotifications.length.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: _deleteSelectedNotifications,
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _notificationsProvider.getNotifications(),
        builder: (BuildContext context,
            AsyncSnapshot<List<NotificationModel>> snapshot) {
          if (isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(AppLocalizations.of(context)!.message_in_progress)
                ],
              ),
            );
          }
          if (snapshot.hasData) {
            _notifications = snapshot.data!;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _notifications.length,
                    itemBuilder: (context, index) {
                      NotificationModel notification = _notifications[index];
                      return Observer(
                        builder: (BuildContext context) {
                          return _notificationItem(notification, context);
                        },
                      );
                    },
                  ),
                ),
                Observer(builder: (context) {
                  return store.selectedNotifications.isNotEmpty
                      ? SafeArea(
                          child: ElevatedButton(
                            onPressed: _markAsReadSelectedNotifications,
                            child: Text(
                              context.appLocalizations
                                      ?.notifications_mark_as_read(
                                          store.selectedNotifications.length) ??
                                  "",
                            ),
                          ),
                        )
                      : const SizedBox.shrink();
                })
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _notificationItem(
      NotificationModel notification, BuildContext context) {
    bool inList = store.selectedNotifications.contains(notification);
    Color bgColor =
        !inList ? Colors.white : const Color.fromRGBO(240, 240, 240, 1);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 2,
        color: bgColor,
        child: ListTile(
          onTap: () {
            inList
                ? store.removeNotification(notification)
                : store.addNotification(notification);
          },
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[200],
            child: ClipOval(
              child: SvgPicture.asset(
                "assets/img/avatars/${notification.avatar}.svg",
              ),
            ),
          ),
          trailing: notification.read
              ? const Icon(Icons.check)
              : const SizedBox.shrink(),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          title: Text(notification.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(notification.body),
              Text(
                timeago.format(notification.created),
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _deleteSelectedNotifications() async {
    setState(() {
      isLoading = true;
    });
    for (NotificationModel notification in store.selectedNotifications) {
      debugPrint("Delete notification ${notification.id}...");
      bool removed =
          await _notificationsProvider.deleteNotification(notification);
      if (removed) {
        _notifications.remove(notification);
      }
    }
    store.clearNotifications();
    setState(() {
      isLoading = false;
    });
  }

  _markAsReadSelectedNotifications() async {
    setState(() {
      isLoading = true;
    });
    for (NotificationModel notification in store.selectedNotifications) {
      debugPrint("Delete notification ${notification.id}...");
      bool markedAsRead = await _notificationsProvider.readNotification(
          notification: notification);
      if (markedAsRead) {
        _notifications.remove(notification);
      }
    }
    store.clearNotifications();
    setState(() {
      isLoading = false;
    });
  }
}
