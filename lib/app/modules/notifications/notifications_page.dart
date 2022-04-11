import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Notification> notifications = [
    Notification('Jose Castro', 'rated your video ”name of video….',
        'avatar-01', DateTime.parse('2022-01-20 13:10'), false),
    Notification('Jorge Perez', 'rated your video ”name of video….',
        'avatar-02', DateTime.parse('2022-01-20 13:10'), false),
    Notification('Luisa Bonilla', 'rated your video ”name of video….',
        'avatar-03', DateTime.parse('2022-01-20 13:10'), false),
    Notification('Angelica Algarra', 'rated your video ”name of video….',
        'avatar-04', DateTime.parse('2022-01-20 13:10'), false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TFAppBar(
        title: Text(
          'Notifications',
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Theme.of(context).primaryColor),
        ),
      ),
      body: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            Notification notification = notifications[index];
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 2,
                color: !notification.read
                    ? Colors.white
                    : const Color.fromRGBO(240, 240, 240, 1),
                child: ListTile(
                    onTap: () {
                      setState(() {
                        notification.read = !notification.read;
                      });
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
                    )),
              ),
            );
          }),
    );
  }
}

class Notification {
  String name;
  String body;
  String avatar;
  DateTime created;
  bool read;

  Notification(this.name, this.body, this.avatar, this.created, this.read);
}
