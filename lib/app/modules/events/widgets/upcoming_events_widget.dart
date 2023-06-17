/* import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:techfrenetic/app/modules/events/events_store.dart';
import 'package:techfrenetic/app/modules/events/widgets/single_event_widget.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';

import '../../../models/events_model.dart';

class UpcomingEventsWidget extends StatefulWidget {
  const UpcomingEventsWidget({super.key});

  @override
  State<UpcomingEventsWidget> createState() => _UpcomingEventsWidgetState();
}

class _UpcomingEventsWidgetState extends State<UpcomingEventsWidget> {
  final _eventsStore = Modular.get<EventsStore>();

  double _scrollPosition = 0;
  late Widget _upcommingEventsWidget;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _eventsStore.recentEventsStore.fetchRecentEvents();
    super.initState();
    _upcommingEventsWidget = _upcommingEvents(context);
    _scrollController.addListener(
      () => setState(() {
        _scrollPosition = _scrollController.position.pixels /
            _scrollController.position.maxScrollExtent;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_searchForm(context), _upcommingEventsWidget, _progressBar()],
    );
  }

  Padding _progressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: LinearProgressIndicator(
        value: _scrollPosition,
      ),
    );
  }

  Widget _upcommingEvents(BuildContext context) {
    return Observer(builder: (builder) {
      final future = _eventsStore.recentEventsFuture;

      if (future == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      switch (future.status) {
        case FutureStatus.pending:
          return const Center(
            child: CircularProgressIndicator(),
          );

        case FutureStatus.rejected:
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Failed to load items.',
                style: TextStyle(color: Colors.red),
              ),
              ElevatedButton(
                child: const Text('Tap to try again'),
                onPressed: _refresh,
              )
            ],
          );

        case FutureStatus.fulfilled:
          List<EventsModel> events = future.result;
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 25),
            height: 470,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...events.map((e) => SingleEventWidget(event: e)).toList(),
                ],
              ),
            ),
          );
      }
    });
  }

  Widget _searchForm(BuildContext context) {
    final theme = Theme.of(context);
    var textTheme = Theme.of(context).textTheme;
    return Container(
      color: theme.primaryColorLight,
      padding: const EdgeInsets.all(36.0),
      child: Column(
        children: [
          Row(
            children: [
              HighlightContainer(
                child: Text(
                  "Upcoming",
                  style: textTheme.headline2?.copyWith(
                      color: theme.colorScheme.primary, fontSize: 26),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "Events",
                style: textTheme.headline2
                    ?.copyWith(color: Colors.black, fontSize: 26),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            "Search upcoming events by",
            textAlign: TextAlign.left,
            style: textTheme.bodyLarge?.copyWith(),
          ),
          TextFormField(
            initialValue: "Write an event name",
            autofocus: true,
            textCapitalization: TextCapitalization.words,
          ),
        ],
      ),
    );
  }

  Future _refresh() => _eventsStore.fetchRecentEvents();
}
 */