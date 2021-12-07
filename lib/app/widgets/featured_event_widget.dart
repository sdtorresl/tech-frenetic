import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/events_model.dart';

class FeaturedEventWidget extends StatefulWidget {
  final EventsModel event;

  const FeaturedEventWidget({Key? key, required this.event}) : super(key: key);

  @override
  _FeaturedEventWidgetState createState() => _FeaturedEventWidgetState();
}

class _FeaturedEventWidgetState extends State<FeaturedEventWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: const Border(
          bottom: BorderSide(
            width: 3.00,
            color: Colors.black,
          ),
        ),
      ),
      child: Column(
        children: [
          CachedNetworkImage(
            placeholder: (context, value) => const LinearProgressIndicator(),
            errorWidget: (context, value, e) => const Icon(Icons.error),
            imageUrl: widget.event.image!,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.event.eventName,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: Colors.white, fontSize: 30),
                ),
                Container(
                  color: Colors.white,
                  width: 55,
                  height: 2.5,
                ),
                const SizedBox(height: 20),
                Text(
                  widget.event.location,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'Oct 26, 2021',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: null,
                      child: Text(
                        'Details',
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor, // background
                        onPrimary: Colors.white, // foreground
                        elevation: 0,
                        side: const BorderSide(width: 1.5, color: Colors.white),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: null,
                      child: Text(
                        'Buy Tickets',
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor, // background
                        onPrimary: Colors.white, // foreground
                        elevation: 0,
                        side: const BorderSide(width: 1.5, color: Colors.white),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
