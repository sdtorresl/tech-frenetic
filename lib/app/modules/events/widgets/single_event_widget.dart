import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/extensions.dart';
import 'package:techfrenetic/app/models/events_model.dart';
import 'package:techfrenetic/app/modules/events/widgets/category_widget.dart';

class SingleEventWidget extends StatelessWidget {
  final EventsModel event;

  const SingleEventWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          event.image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(event.image!),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              event.eventName,
              style: textTheme.headline2?.copyWith(height: 1.25),
            ),
          ),
          CategoryWidget(
            category: event.category,
            elevation: 0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              event.location,
              style: textTheme.bodyText1?.copyWith(color: colorTheme.secondary),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              event.startDate.toHumanDate(),
              style: textTheme.bodyText1?.copyWith(color: colorTheme.secondary),
            ),
          )
        ],
      ),
    );
  }
}
