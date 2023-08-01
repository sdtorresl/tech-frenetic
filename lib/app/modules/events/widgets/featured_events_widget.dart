import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/modules/events/widgets/featured_event_widget.dart';
import 'package:techfrenetic/app/modules/events/widgets/no_events_widget.dart';
import 'package:techfrenetic/app/widgets/highlighted_title_widget.dart';

import '../events_store.dart';

class FeaturedEventsWidget extends StatefulWidget {
  const FeaturedEventsWidget({super.key});

  @override
  State<FeaturedEventsWidget> createState() => _FeaturedEventsWidgetState();
}

class _FeaturedEventsWidgetState extends State<FeaturedEventsWidget> {
  final EventsStore _eventStore = Modular.get<EventsStore>();

  @override
  void initState() {
    if (_eventStore.featuredEvents.isEmpty) {
      _eventStore.fetchFeaturedEvents();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 227, 236, 250),
      padding: const EdgeInsets.all(36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HighlightedTitleWidget(
            text: context.appLocalizations?.events_featured ?? '',
          ),
          Observer(
            builder: (BuildContext context) {
              switch (_eventStore.featuredEventsState) {
                case StoreState.initial:
                  return const NoEventsWidget();
                case StoreState.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case StoreState.loaded:
                  if (_eventStore.featuredEvents.isEmpty) {
                    return const NoEventsWidget(
                      padding: EdgeInsets.only(top: 20),
                    );
                  }

                  List<Widget> eventsWidgets = _eventStore.featuredEvents
                      .map((e) => FeaturedEventWidget(
                            event: e,
                          ))
                      .toList();
                  return Column(children: eventsWidgets);
              }
            },
          ),
        ],
      ),
    );
  }
}
