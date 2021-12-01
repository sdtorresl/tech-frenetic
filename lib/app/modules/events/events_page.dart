import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:techfrenetic/app/widgets/post_event_widget.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

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

class _EventsPageState extends State<EventsPage> {
  Widget postEvent = const PostEventWidget();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: const Border(
              bottom: BorderSide(
                width: 3.00,
                color: Colors.black,
              ),
            ),
          ),
          child: Column(
            children: [
              CachedNetworkImage(
                placeholder: (context, value) =>
                    const LinearProgressIndicator(),
                errorWidget: (context, value, e) => const Icon(Icons.error),
                imageUrl:
                    "https://akm-img-a-in.tosshub.com/indiatoday/images/story/201810/stockvault-person-studying-and-learning---knowledge-concept178241_0-647x363.jpeg?0LocAW2E2gIBzZp0oZSWzxmQTvAPhN_v&size=1200:675",
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '{API:WORLD}',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: Colors.white, fontSize: 30),
                    ),
                    Container(
                      color: Colors.white,
                      width: 55,
                      height: 2.5,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'ALL VIRTUAL',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      'Oct 26, 2021',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        width: 300,
                        child: ElevatedButton(
                          onPressed: null,
                          child: Text(
                            'Details',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary:
                                Theme.of(context).primaryColor, // background
                            onPrimary: Colors.white, // foreground
                            elevation: 0,
                            side: const BorderSide(
                                width: 1.5, color: Colors.white),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                        width: 300,
                        child: ElevatedButton(
                          onPressed: null,
                          child: Text(
                            'Buy Tickets',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary:
                                Theme.of(context).primaryColor, // background
                            onPrimary: Colors.white, // foreground
                            elevation: 0,
                            side: const BorderSide(
                                width: 1.5, color: Colors.white),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ],
          ),
        ),
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
                    AppLocalizations.of(context)!.featured,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 25),
                  ),
                ),
                Text(
                  ' ' + AppLocalizations.of(context)!.featured_events,
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
              AppLocalizations.of(context)!.event_serch,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 20, color: Theme.of(context).primaryColor),
            ),
            Container(
              color: Colors.white,
              child: DropdownButton<String>(
                value: defaultValue,
                isExpanded: true,
                underline: Container(
                  height: 0.5,
                  color: Colors.black,
                ),
                hint: Text(
                  'Your profession',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).hintColor),
                ),
                items: items.map(
                  (String valueItem) {
                    return DropdownMenuItem<String>(
                      child: Text(valueItem),
                      value: valueItem,
                    );
                  },
                ).toList(),
                onChanged: (newValue) {
                  setState(
                    () {
                      defaultValue = newValue;
                      debugPrint(defaultValue);
                    },
                  );
                },
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
                  child: Text(AppLocalizations.of(context)!.search),
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
                    AppLocalizations.of(context)!.upcoming,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 25),
                  ),
                ),
                Text(
                  ' ' + AppLocalizations.of(context)!.events,
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
                    AppLocalizations.of(context)!.recent,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 25),
                  ),
                ),
                Text(
                  ' ' + AppLocalizations.of(context)!.recent_events,
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
