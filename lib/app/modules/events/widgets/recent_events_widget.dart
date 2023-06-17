import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/models/events_model.dart';
import 'package:techfrenetic/app/modules/events/events_store.dart';
import 'package:techfrenetic/app/modules/events/widgets/single_event_widget.dart';

import '../../../widgets/highlighted_title_widget.dart';
import '../recent_events_store.dart';

class RecentEventsWidget extends StatefulWidget {
  const RecentEventsWidget({super.key});

  @override
  State<RecentEventsWidget> createState() => _RecentEventsWidgetState();
}

class _RecentEventsWidgetState extends State<RecentEventsWidget> {
  final _eventsStore = Modular.get<RecentEventsStore>();

  double _scrollPosition = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    if (_eventsStore.recentEvents.isEmpty) {
      _eventsStore.fetchRecentEvents();
    }
    super.initState();
    _scrollController.addListener(
      () => setState(() {
        if (_scrollController.position.maxScrollExtent > 0) {
          _scrollPosition = _scrollController.position.pixels /
              _scrollController.position.maxScrollExtent;
        } else {
          _scrollPosition = 0;
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _searchForm(context),
        _recentEvents(context),
        _progressBar(),
      ],
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

  Widget _recentEvents(BuildContext context) {
    return Observer(builder: (builder) {
      switch (_eventsStore.state) {
        case StoreState.initial:
        case StoreState.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );

        case StoreState.loaded:
          List<EventsModel> _events =
              _eventsStore.filteredRecentEvents.isNotEmpty
                  ? _eventsStore.filteredRecentEvents
                  : _eventsStore.recentEvents;

          return SizedBox(
            height: 410,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ..._events.map((e) => SingleEventWidget(event: e)).toList(),
                ],
              ),
            ),
          );
      }
    });
  }

  Widget _searchForm(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.textTheme;

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
            controller: _eventsStore.nameEditingController,
            decoration: InputDecoration(
              label: Text(context.appLocalizations?.name ?? ''),
              hintText: 'Drupalcon',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              onPressed: _eventsStore.search,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  context.appLocalizations?.search ?? '',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future _refresh() => _eventsStore.fetchRecentEvents();
}
