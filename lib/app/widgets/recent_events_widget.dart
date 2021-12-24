import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:techfrenetic/app/models/events_model.dart';
import 'package:techfrenetic/app/providers/recent_events_provider.dart';
import 'package:techfrenetic/app/widgets/post_recent_event_widget.dart';

class RecentEventsWidget extends StatefulWidget {
  const RecentEventsWidget({Key? key}) : super(key: key);

  @override
  _RecentEventsWidgetState createState() => _RecentEventsWidgetState();
}

class _RecentEventsWidgetState extends State<RecentEventsWidget> {
  @override
  Widget build(BuildContext context) {
    RecentEventsProvider _eventsprovider = RecentEventsProvider();

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).splashColor.withOpacity(0.1),
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
                    AppLocalizations.of(context)!.recent,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 25),
                  ),
                ),
                Text(
                  ' ' + AppLocalizations.of(context)!.recent_events,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 25),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: _eventsprovider.getRecentEvents(),
            builder: (BuildContext context,
                AsyncSnapshot<List<EventsModel>> snapshot) {
              if (snapshot.hasData) {
                List<EventsModel> events = snapshot.data ?? [];
                List<Widget> postsEventWidgets = [];

                for (EventsModel event in events) {
                  postsEventWidgets.add(
                    PostRecentEventWidget(event: event),
                  );
                }

                return Column(
                  children: [
                    ...postsEventWidgets,
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          const SizedBox(height: 70),
        ],
      ),
    );
  }
}
