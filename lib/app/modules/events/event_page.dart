import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/common/launch_url.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/models/detailed_event_model.dart';
import 'package:techfrenetic/app/modules/events/event_store.dart';
import 'package:techfrenetic/app/modules/events/widgets/header_event_widget.dart';
import 'package:techfrenetic/app/modules/events/widgets/speakers_list_widget.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';

import 'widgets/sponsors_list_widget.dart';

class EventPage extends StatefulWidget {
  final String slug;
  const EventPage({super.key, required this.slug});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final ScrollController _scrollController = ScrollController();

  final EventStore _eventStore = Modular.get<EventStore>();

  @override
  void initState() {
    super.initState();
    _eventStore.fetchEvent(widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TFAppBar(),
      body: _body(),
    );
  }

  Widget _body() {
    return Observer(builder: (context) {
      switch (_eventStore.state) {
        case StoreState.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case StoreState.initial:
          return const Center(
            child: Text("No event was found"),
          );
        default:
          if (_eventStore.event != null) {
            return _eventView(_eventStore.event!);
          }

          return const Center(child: Text("Event not found"));
      }
    });
  }

  Widget _eventView(DetailedEventModel event) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          Image.network(event.image!),
          HeaderEventWidget(
            event: event,
            showCategory: true,
            backgroundColor: context.colorScheme.primary,
            foregroundColor: Colors.white,
            actions: event.ticketLink != null
                ? [
                    OutlinedButton(
                      onPressed: () => openUrl(event.ticketLink!),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          context.appLocalizations?.events_buy ?? '',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent,
                        side: const BorderSide(color: Colors.white, width: 1),
                      ),
                    )
                  ]
                : null,
          ),
          _eventDescription(event.longDescription ?? ''),
          SpeakersListWidget(speakers: event.speakers),
          SponsorsListWidget(sponsors: event.sponsors)
        ],
      ),
    );
  }

  _eventDescription(String description) {
    return description.isEmpty
        ? const SizedBox.shrink()
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
            color: Colors.white,
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(description),
              ),
            ),
          );
  }
}
