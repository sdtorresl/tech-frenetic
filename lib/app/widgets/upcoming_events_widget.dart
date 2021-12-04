import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:techfrenetic/app/widgets/post_recent_event_widget.dart';
import 'package:techfrenetic/app/models/events_model.dart';
import 'package:techfrenetic/app/providers/upcoming_events_provider.dart';
import 'package:techfrenetic/app/widgets/post_upcoming_events_widget.dart';

class UpcomingEventsWidget extends StatefulWidget {
  const UpcomingEventsWidget({Key? key}) : super(key: key);

  @override
  _UpcomingEventsWidgetState createState() => _UpcomingEventsWidgetState();
}

class _UpcomingEventsWidgetState extends State<UpcomingEventsWidget> {
  @override
  Widget build(BuildContext context) {
    UpcomingProvider _upcomingEventsprovider = UpcomingProvider();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1.00,
            color: Colors.grey.withOpacity(.3),
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                HighlightContainer(
                  child: Text(
                    AppLocalizations.of(context)!.upcoming,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 25),
                  ),
                ),
                Text(
                  ' ' + AppLocalizations.of(context)!.events,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 25),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: _upcomingEventsprovider.getUpcomingEvents(),
            builder: (BuildContext context,
                AsyncSnapshot<List<EventsModel>> snapshot) {
              if (snapshot.hasData) {
                List<EventsModel> events = snapshot.data ?? [];
                List<Widget> postsEventWidgets = [];

                for (EventsModel event in events) {
                  if (events.isNotEmpty) {
                    postsEventWidgets
                        .add(PostUpcomingEventWidget(event: event));
                    postsEventWidgets.add(const SizedBox());
                  } else {
                    postsEventWidgets.add(const SizedBox());
                  }
                }

                return Column(
                  children: [
                    ...postsEventWidgets,
                    const SizedBox(height: 60),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
    ;
  }
}
