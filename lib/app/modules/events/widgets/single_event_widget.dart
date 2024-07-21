import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/core/extensions.dart';
import 'package:techfrenetic/app/models/events_model.dart';
import 'package:techfrenetic/app/widgets/category_widget.dart';

class SingleEventWidget extends StatelessWidget {
  final EventsModel event;

  const SingleEventWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          event.image != null
              ? GestureDetector(
                  onTap: () => Modular.to.pushNamed("/events/${event.slug}"),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(event.image!),
                  ),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: InkWell(
              onTap: () => Modular.to.pushNamed("/events/${event.slug}"),
              child: Text(
                event.eventName,
                style: textTheme.headline2?.copyWith(height: 1.25),
              ),
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
