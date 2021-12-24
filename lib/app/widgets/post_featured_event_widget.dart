import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:techfrenetic/app/core/utils.dart';
import 'package:techfrenetic/app/models/events_model.dart';

class PostFeaturedEventWidget extends StatefulWidget {
  final EventsModel event;
  const PostFeaturedEventWidget({Key? key, required this.event})
      : super(key: key);

  @override
  _PostFeaturedEventWidgetState createState() =>
      _PostFeaturedEventWidgetState();
}

class _PostFeaturedEventWidgetState extends State<PostFeaturedEventWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1.00,
            color: Theme.of(context).primaryColor,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              widget.event.category,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 13, color: Theme.of(context).primaryColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
            child: Text(
              widget.event.eventName,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Theme.of(context).primaryColor,
                ),
                Text(
                  widget.event.location,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: SvgPicture.asset(
                    'assets/img/icons/dot.svg',
                    semanticsLabel: 'Dot',
                    color: Colors.grey,
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(simpleDateFormatter.format(widget.event.startDate),
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
