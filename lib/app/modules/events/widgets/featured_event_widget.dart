import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/events_model.dart';

class FeaturedEventWidget extends StatelessWidget {
  final EventsModel event;

  const FeaturedEventWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35, bottom: 25),
      child: Column(
        children: [
          event.image != null
              ? Image.network(
                  event.image!,
                  fit: BoxFit.fitWidth,
                  height: 250,
                  width: double.infinity,
                )
              : const SizedBox.shrink(),
          Container(
            alignment: Alignment.centerLeft,
            color: const Color.fromARGB(255, 255, 238, 0),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Coming on: ${event.startDate}",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.normal,
                    ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
