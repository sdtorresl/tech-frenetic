import 'package:flutter/material.dart';
import 'package:techfrenetic/app/modules/events/widgets/header_widget.dart';
import 'package:techfrenetic/app/modules/events/widgets/nearest_event_widget.dart';
import 'package:techfrenetic/app/modules/events/widgets/recent_events_widget.dart';
import 'package:techfrenetic/app/modules/events/widgets/upcoming_events_widget.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TFAppBar(),
      body: ListView(
        children: [
          const HeaderWidget(),
          const NearestEventWidget(),
          Image.network(
            "https://picsum.photos/700/300",
            fit: BoxFit.fitWidth,
          ),
          //const FeaturedEventsWidget(),
          const UpcommingEventsWidget(),
          const RecentEventsWidget(),
        ],
      ),
    );
  }
}
