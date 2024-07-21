import 'package:flutter/material.dart';
import 'package:techfrenetic/app/modules/events/widgets/featured_events_widget.dart';
import 'package:techfrenetic/app/modules/events/widgets/recent_event_widget.dart';
import 'package:techfrenetic/app/modules/events/widgets/recent_events_widget.dart';
import 'package:techfrenetic/app/modules/events/widgets/upcoming_events_widget.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';
import 'package:techfrenetic/app/widgets/separator_image_widget.dart';

import 'widgets/header_widget.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = ScrollController();
    return Scaffold(
      appBar: TFAppBar(),
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: [
            const HeaderWidget(),
            const RecentEventWidget(),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                child: Stack(
                  children: [
                    SeparatorImageWidget(
                      image: 'assets/img/events/startco3.jpeg',
                    ),
                  ],
                ),
              ),
            ),
            const FeaturedEventsWidget(),
            const UpcommingEventsWidget(),
            const RecentEventsWidget(),
          ],
        ),
      ),
    );
  }
}
