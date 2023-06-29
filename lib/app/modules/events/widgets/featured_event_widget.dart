import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/core/extensions.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/models/events_model.dart';
import 'package:techfrenetic/app/modules/events/widgets/category_widget.dart';

class FeaturedEventWidget extends StatelessWidget {
  final EventsModel event;

  const FeaturedEventWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35, bottom: 25),
      child: Column(
        children: [
          _cardHeader(context),
          Container(
            alignment: Alignment.centerLeft,
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.eventName,
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    event.location,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${context.appLocalizations?.events_comming_on}: ${event.startDate.toHumanDate()}",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () =>
                            Modular.to.pushNamed("/events/${event.nid}"),
                        label: const Icon(Icons.arrow_forward),
                        icon: Text(
                            context.appLocalizations?.events_learn_more ?? ''),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _cardHeader(BuildContext context) {
    return event.image != null
        ? Stack(
            children: [
              Image.network(
                event.image!,
                fit: BoxFit.fitWidth,
                height: 175,
                width: double.infinity,
              ),
              Positioned(
                left: 10,
                bottom: 10,
                child: CategoryWidget(
                  category: event.category,
                ),
              )
            ],
          )
        : const SizedBox.shrink();
  }
}
