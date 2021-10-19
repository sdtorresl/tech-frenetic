import 'package:flutter/material.dart';

class MeetupWidget extends StatefulWidget {
  MeetupWidget({Key? key}) : super(key: key);

  @override
  _MeetupWidgetState createState() => _MeetupWidgetState();
}

class _MeetupWidgetState extends State<MeetupWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
          child: Container(
            //color: Colors.white,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  width: 1.90,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            child: Card(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Upcomming '),
                      Text('Meetups'),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Find here upcoming from the Tech Frenetic Community in yourarea so you learn, share, and work together.',
                    textAlign: TextAlign.center,
                    style: TextStyle(height: 2.0),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Card(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('Host a Meetup',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                      child: Row(
                    children: [
                      SizedBox(width: 20),
                      Text(
                        '(0) ',
                      ),
                      Text('Meetups'),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
