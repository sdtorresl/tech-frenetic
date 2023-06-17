import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/modules/events/events_store.dart';
import 'package:techfrenetic/app/modules/events/widgets/single_event_widget.dart';

import '../../../models/events_model.dart';
import '../../../widgets/highlighted_title_widget.dart';

class RecentEventsWidget extends StatefulWidget {
  const RecentEventsWidget({super.key});

  @override
  State<RecentEventsWidget> createState() => _RecentEventsWidgetState();
}

class _RecentEventsWidgetState extends State<RecentEventsWidget> {
  final _eventsStore = Modular.get<EventsStore>();

  double _scrollPosition = 0;
  late Widget _upcommingEventsWidget;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _eventsStore.fetchRecentEvents();
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
    final theme = context.theme;
    var textTheme = context.textTheme;

    return Container(
      color: theme.primaryColorLight,
      padding: const EdgeInsets.all(36.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HighlightedTitleWidget(
              text: context.appLocalizations?.events_recent ?? ''),
          const SizedBox(
            height: 25,
          ),
          Text(
            "${context.appLocalizations?.events_search_recent ?? ''}:",
            textAlign: TextAlign.left,
            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
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
