import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/events_model.dart';
import 'package:techfrenetic/app/modules/events/widgets/featured_event_widget.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';

import '../../../providers/events_provider.dart';

class FeaturedEventsWidget extends StatefulWidget {
  const FeaturedEventsWidget({super.key});

  @override
  State<FeaturedEventsWidget> createState() => _FeaturedEventsWidgetState();
}

class _FeaturedEventsWidgetState extends State<FeaturedEventsWidget> {
  final EventsProvider _eventsprovider = EventsProvider();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 35.0, top: 40, bottom: 40),
          child: Row(
            children: [
              HighlightContainer(
                child: Text(
                  "Featured",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        color: const Color.fromRGBO(5, 105, 216, 1),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "Events",
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(fontSize: 26),
              ),
            ],
          ),
        ),
        FutureBuilder(
          future: _eventsprovider.getFeaturedEvents(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<EventsModel> events = snapshot.data;
              List<Widget> eventsWidgets = events
                  .map((e) => FeaturedEventWidget(
                        event: e,
                      ))
                  .toList();
              return Column(children: eventsWidgets);
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}
