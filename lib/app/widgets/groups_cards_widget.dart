import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GroupsCardsWidget extends StatefulWidget {
  const GroupsCardsWidget({Key? key}) : super(key: key);

  @override
  _GroupsCardsWidgetState createState() => _GroupsCardsWidgetState();
}

class _GroupsCardsWidgetState extends State<GroupsCardsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 40,
            child: ClipOval(
              child: CachedNetworkImage(
                placeholder: (context, value) =>
                    const LinearProgressIndicator(),
                errorWidget: (context, value, e) => const Icon(Icons.error),
                imageUrl:
                    "https://akm-img-a-in.tosshub.com/indiatoday/images/story/201810/stockvault-person-studying-and-learning---knowledge-concept178241_0-647x363.jpeg?0LocAW2E2gIBzZp0oZSWzxmQTvAPhN_v&size=1200:675",
                fit: BoxFit.cover,
                width: 60,
                height: 80,
              ),
            ),
          ),
          title: Text(
            'Digital Nomads',
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '45 members - 90',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).hintColor, fontSize: 13),
              ),
              Text(
                'posts',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).hintColor, fontSize: 13),
              ),
            ],
          ),
          trailing: ElevatedButton(
            onPressed: null,
            child: Text(
              'Join Group',
              style:
                  Theme.of(context).textTheme.headline1!.copyWith(fontSize: 13),
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
