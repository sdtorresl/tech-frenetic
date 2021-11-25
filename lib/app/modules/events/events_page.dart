import 'package:flutter/material.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:techfrenetic/app/widgets/post_event.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  Widget postEvent = const PostEventWidget();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        featureEvents(),
        eventSerch(),
        upcomingEvents(),
        recentEvents(),
      ],
    );
  }

  Widget featureEvents() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1.00,
            color: Colors.grey.withOpacity(.3),
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                HighlightContainer(
                  child: Text(
                    'Featured',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 25),
                  ),
                ),
                Text(
                  ' events',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 25),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 45,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      width: 1.00,
                      color: Theme.of(context).primaryColor,
                    ),
                    left: BorderSide(
                      width: 0.50,
                      color: Colors.grey.withOpacity(.6),
                    ),
                    top: BorderSide(
                      width: 0.50,
                      color: Colors.grey.withOpacity(.6),
                    ),
                    right: BorderSide(
                      width: 0.50,
                      color: Colors.grey.withOpacity(.6),
                    ),
                  ),
                ),
                child: postEvent),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget eventSerch() {
    List<String> items = [
      'Category',
      'Applications',
      'Cloud',
      'Consulting & Sales',
      'Cibersecurity',
      'Networking',
      'Servers & PCs',
      'Storage',
    ];
    String? defaultValue = items.first;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).splashColor.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            width: 1.00,
            color: Colors.grey.withOpacity(.3),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Event Serch:',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 20, color: Theme.of(context).primaryColor),
            ),
            Container(
              color: Colors.white,
              child: DropdownButton<String>(
                value: defaultValue,
                isExpanded: true,
                underline: Container(
                  height: 2,
                  color: Theme.of(context).primaryColor,
                ),
                onChanged: (newValue) {
                  setState(
                    () {
                      defaultValue = newValue!;
                    },
                  );
                },
                style: Theme.of(context).textTheme.bodyText1,
                items: items.map(
                  (String valueItem) {
                    return DropdownMenuItem<String>(
                      child: Text(valueItem),
                      value: valueItem,
                    );
                  },
                ).toList(),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              color: Colors.white,
              child: TextFormField(),
            ),
            const SizedBox(height: 25),
            Center(
              child: SizedBox(
                width: 400,
                child: ElevatedButton(
                  child: const Text('search'),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                  onPressed: () {
                    return debugPrint('Im working');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget upcomingEvents() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1.00,
            color: Colors.grey.withOpacity(.3),
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                HighlightContainer(
                  child: Text(
                    'Upcoming',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 25),
                  ),
                ),
                Text(
                  ' events',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 25),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      width: 0.50,
                      color: Theme.of(context).unselectedWidgetColor,
                    ),
                    left: BorderSide(
                      width: 0.50,
                      color: Colors.grey.withOpacity(.6),
                    ),
                    top: BorderSide(
                      width: 0.50,
                      color: Colors.grey.withOpacity(.6),
                    ),
                    right: BorderSide(
                      width: 0.50,
                      color: Colors.grey.withOpacity(.6),
                    ),
                  ),
                ),
                margin: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 45,
                ),
                child: postEvent),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget recentEvents() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).splashColor.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            width: 1.00,
            color: Colors.grey.withOpacity(.3),
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                HighlightContainer(
                  child: Text(
                    'Recent',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 25),
                  ),
                ),
                Text(
                  ' events',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 25),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  //border: Border(
                  //bottom: BorderSide(
                  //  width: 1.00,
                  //    color: Theme.of(context).primaryColor,
                  //  ),
                  // left: BorderSide(
                  //   width: 0.50,
                  //    color: Colors.grey.withOpacity(.6),
                  //  ),
                  // ),
                ),
                margin: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 45,
                ),
                child: postEvent),
          ),
          const SizedBox(height: 70),
        ],
      ),
    );
  }
}
