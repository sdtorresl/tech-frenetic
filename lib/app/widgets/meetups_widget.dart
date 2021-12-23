import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/models/meetups_model.dart';

import 'package:flutter_svg/flutter_svg.dart';

class MeetupWidget extends StatefulWidget {
  final MeetupsModel meetup;

  const MeetupWidget({Key? key, required this.meetup}) : super(key: key);

  @override
  _MeetupWidgetState createState() => _MeetupWidgetState();
}

class _MeetupWidgetState extends State<MeetupWidget> {
  @override
  Widget build(BuildContext context) {
    String monthAndDay = DateFormat('MMM dd').format(widget.meetup.when);
    String day = DateFormat('EEE').format(widget.meetup.when);
    String meetupDay = DateFormat('EEEE, MMM dd').format(widget.meetup.when);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  width: 0.50,
                  color: Colors.grey.withOpacity(.6),
                ),
                bottom: BorderSide(
                  width: 0.50,
                  color: Colors.grey.withOpacity(.6),
                ),
                left: BorderSide(
                  width: 0.50,
                  color: Colors.grey.withOpacity(.6),
                ),
                right: BorderSide(
                  width: 0.50,
                  color: Colors.grey.withOpacity(.6),
                ),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 15),
                Text(
                  monthAndDay,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: Theme.of(context).indicatorColor),
                ),
                Text(
                  day,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 20),
                Container(
                  color: Colors.grey.withOpacity(.6),
                  width: 400,
                  height: 1.0,
                ),
                const SizedBox(height: 15),
                Text(
                  widget.meetup.title,
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(height: 30),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: SvgPicture.asset(
                      'assets/img/avatars/avatar-02.svg',
                      semanticsLabel: 'Acme Logo',
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
                Text(
                  'By ' + widget.meetup.displayName,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).indicatorColor),
                ),
                const SizedBox(height: 10),
                SvgPicture.asset(
                  'assets/img/icons/dot.svg',
                  allowDrawingOutsideViewBox: true,
                  semanticsLabel: 'Dot',
                  color: Theme.of(context).primaryColor,
                  height: 15,
                  width: 15,
                ),
                const SizedBox(height: 10),
                Text(
                  meetupDay,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Theme.of(context).indicatorColor,
                    ),
                    Text(
                      widget.meetup.where,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
