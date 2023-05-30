import 'package:flutter/material.dart';

class UpcomingEventWidget extends StatelessWidget {
  const UpcomingEventWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.amber.shade50,
      child: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Upcoming ",
                  textAlign: TextAlign.left,
                  textScaleFactor: 2.1,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color.fromRGBO(5, 105, 216, 1),
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.blue[200]),
                ),
                Text(
                  "Events",
                  textAlign: TextAlign.left,
                  textScaleFactor: 2.1,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Search upcoming events by",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            TextFormField(
              initialValue: "Write an event name",
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              //style:
            )
          ],
        ),
      ),
    );
  }
}
