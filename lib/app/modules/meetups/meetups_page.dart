import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/models/meetups_model.dart';
import 'package:techfrenetic/app/providers/meetups_provider.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:techfrenetic/app/widgets/meetups_widget.dart';

class MetupsPage extends StatefulWidget {
  const MetupsPage({Key? key}) : super(key: key);

  @override
  _MetupsPageState createState() => _MetupsPageState();
}

class _MetupsPageState extends State<MetupsPage> {
  @override
  Widget build(BuildContext context) {
    MeetupsProvider meetupsProvideer = MeetupsProvider();
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    width: 1.90,
                    color: Theme.of(context).primaryColor,
                  ),
                  bottom: BorderSide(
                    width: 1.00,
                    color: Theme.of(context).unselectedWidgetColor,
                  ),
                  left: BorderSide(
                    width: 0.50,
                    color: Colors.grey.withOpacity(.6),
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).unselectedWidgetColor,
                    spreadRadius: -5,
                    blurRadius: 5,
                    offset: const Offset(1.9, 1.7),
                  )
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HighlightContainer(
                        child: Text(
                          AppLocalizations.of(context)!.meetups_ttl_blue,
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontSize: 25,
                                    color: Theme.of(context).primaryColor,
                                  ),
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.meetups_ttl_black,
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 25),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)!.meetups_intro,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(height: 2),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  ElevatedButton(
                    onPressed: () => Modular.to.pushNamed('/create_meetups'),
                    child: Text(
                      AppLocalizations.of(context)!.meetups_cta_new,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FutureBuilder(
                      future: meetupsProvideer.getMeetupsWall(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          MeetupsWallModel wall = snapshot.data;
                          return Text(
                              "(${wall.results}) ${AppLocalizations.of(context)!.meetups_ttl_black}");
                        } else {
                          return const Text('(0)');
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                    future: meetupsProvideer.getMeetups(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        List<MeetupsModel> meetups = snapshot.data ?? [];
                        List<Widget> meetupWidgets = [];

                        for (MeetupsModel meetup in meetups) {
                          meetupWidgets.add(MeetupWidget(meetup: meetup));
                        }

                        return Column(
                          children: [
                            ...meetupWidgets,
                            const SizedBox(height: 20),
                          ],
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
