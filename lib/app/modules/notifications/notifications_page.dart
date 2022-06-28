import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
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

class _NotificationsPageState
    extends ModularState<NotificationsPage, NotificationsStore> {
  final NotificationsProvider _notificationsProvider = NotificationsProvider();

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
          ]),
      body: FutureBuilder(
        future: _notificationsProvider.getNotifications(),
        builder: (BuildContext context,
            AsyncSnapshot<List<NotificationModel>> snapshot) {
          if (snapshot.hasData) {
            List<NotificationModel> notifications = snapshot.data!;

            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                NotificationModel notification = notifications[index];
                return Observer(
                  builder: (BuildContext context) {
                    bool inList =
                        store.selectedNotifications.contains(notification);
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 2,
                        color: !inList
                            ? Colors.white
                            : const Color.fromRGBO(240, 240, 240, 1),
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
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          title: Text(notification.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(notification.body),
                              Text(
                                timeago.format(notification.created),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: Colors.grey, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
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

  _deleteSelectedNotifications() {
    for (NotificationModel notification in store.selectedNotifications) {
      debugPrint("Delete notification ${notification.body}...");
    }
    store.clearNotifications();
    setState(() {});
  }
}
