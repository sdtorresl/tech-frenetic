import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:techfrenetic/app/models/events_model.dart';
import 'package:techfrenetic/app/widgets/post_featured_event_widget.dart';
import 'package:techfrenetic/app/providers/featured_events_provider.dart';
import 'package:techfrenetic/app/widgets/section_header_widget.dart';

class FeaturedEventsWidget extends StatefulWidget {
  const FeaturedEventsWidget({Key? key}) : super(key: key);

  @override
  _FeaturedEventsWidgetState createState() => _FeaturedEventsWidgetState();
}

class _FeaturedEventsWidgetState extends State<FeaturedEventsWidget> {
  @override
  Widget build(BuildContext context) {
    FeaturedEventsProvider _eventsprovider = FeaturedEventsProvider();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SectionHeaderWidget(
            child: Row(
              children: [
                HighlightContainer(
                  child: Text(
                    AppLocalizations.of(context)!.featured,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 25),
                  ),
                ),
                Text(
                  ' ' + AppLocalizations.of(context)!.featured_events,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 25),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: _eventsprovider.getFeaturedEvents(),
            builder: (BuildContext context,
                AsyncSnapshot<List<EventsModel>> snapshot) {
              if (snapshot.hasData) {
                List<EventsModel> events = snapshot.data ?? [];
                List<Widget> postsEventWidgets = [];

                for (EventsModel event in events) {
                  postsEventWidgets.add(PostFeaturedEventWidget(event: event));
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
        ],
      ),
    );
  }
}
