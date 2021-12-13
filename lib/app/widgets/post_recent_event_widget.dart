import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techfrenetic/app/models/events_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostRecentEventWidget extends StatefulWidget {
  final EventsModel event;
  const PostRecentEventWidget({Key? key, required this.event})
      : super(key: key);

  @override
  _PostRecentEventWidgetState createState() => _PostRecentEventWidgetState();
}

class _PostRecentEventWidgetState extends State<PostRecentEventWidget> {
  @override
  Widget build(BuildContext context) {
    final startDate = widget.event.startDate;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 45,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            placeholder: (context, value) => const LinearProgressIndicator(),
            errorWidget: (context, value, e) => const Icon(Icons.error),
            imageUrl: widget.event.image!,
          ),
          const SizedBox(height: 10),
          Text(
            widget.event.category,
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontSize: 13, color: Theme.of(context).primaryColor),
          ),
          const SizedBox(height: 10),
          Text(
            widget.event.eventName,
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
                widget.event.location,
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
              Text('Oct 26, 2021',
                  style: Theme.of(context).textTheme.bodyText1),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
