import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techfrenetic/app/models/events_model.dart';

class PostUpcomingEventWidget extends StatefulWidget {
  final EventsModel event;
  const PostUpcomingEventWidget({Key? key, required this.event})
      : super(key: key);

  @override
  _PostUpcomingEventWidgetState createState() =>
      _PostUpcomingEventWidgetState();
}

class _PostUpcomingEventWidgetState extends State<PostUpcomingEventWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 45,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 0.50,
            color: Theme.of(context).unselectedWidgetColor,
          ),
          left: BorderSide(
            width: 0.50,
            color: Colors.grey.withOpacity(.6),
          ),
          top: BorderSide(
            width: 0.50,
            color: Colors.grey.withOpacity(.6),
          ),
          right: BorderSide(
            width: 0.50,
            color: Colors.grey.withOpacity(.6),
          ),
        ),
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
