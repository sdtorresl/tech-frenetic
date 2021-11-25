import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostEventWidget extends StatefulWidget {
  const PostEventWidget({Key? key}) : super(key: key);

  @override
  _PostEventWidgetState createState() => _PostEventWidgetState();
}

class _PostEventWidgetState extends State<PostEventWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          placeholder: (context, value) => const LinearProgressIndicator(),
          errorWidget: (context, value, e) => const Icon(Icons.error),
          imageUrl:
              "https://akm-img-a-in.tosshub.com/indiatoday/images/story/201810/stockvault-person-studying-and-learning---knowledge-concept178241_0-647x363.jpeg?0LocAW2E2gIBzZp0oZSWzxmQTvAPhN_v&size=1200:675",
        ),
        const SizedBox(height: 10),
        Text(
          'APPLICATIONS',
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(fontSize: 13, color: Theme.of(context).primaryColor),
        ),
        const SizedBox(height: 10),
        Text(
          '{API:WORLD}',
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Icon(
              Icons.location_on,
              color: Theme.of(context).primaryColor,
            ),
            Text(
              'ALL VIRTUAL',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SvgPicture.asset(
              'assets/img/icons/dot.svg',
              semanticsLabel: 'Dot',
              color: Colors.grey,
            ),
            Icon(
              Icons.calendar_today,
              color: Theme.of(context).primaryColor,
            ),
            Text('Oct 26, 2021', style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
