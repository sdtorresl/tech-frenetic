import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:techfrenetic/app/modules/create_meetups/create_metups_controller.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';

class CreateMeetupsPage extends StatefulWidget {
  const CreateMeetupsPage({Key? key}) : super(key: key);

  @override
  _CreateMeetupsPageState createState() => _CreateMeetupsPageState();
}

class _CreateMeetupsPageState
    extends ModularState<CreateMeetupsPage, CreateMeetupsController> {
  bool _isLoading = false;
  DateTime? datePicked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 25,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HighlightContainer(
                      child: Text(
                        'Host a',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 30,
                              color: Theme.of(context).indicatorColor,
                            ),
                      ),
                    ),
                    Text(
                      'Meetup',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 30),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Connect with other Tech Frenetic´s',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 16),
                ),
                Text(
                  'members in your area',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 16),
                ),
                const SizedBox(height: 40),
                form(),
                const SizedBox(height: 40),
                Container(
                  color: Colors.grey.withOpacity(.1),
                  width: 400,
                  height: 4,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 400,
                  child: StreamBuilder(
                    stream: store.formValidStream,
                    builder: (context, snapshot) {
                      return ElevatedButton(
                        onPressed: snapshot.hasData && !_isLoading
                            ? () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                bool createMeetup = await store.createMeetups();
                                setState(() {
                                  _isLoading = false;
                                });
                                if (createMeetup) {
                                  debugPrint('Meetup created');
                                } else {
                                  debugPrint("Meetup not created");
                                }
                              }
                            : null,
                        child: Text(
                          'Post your meetup',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontSize: 20, color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget form() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Where *',
          style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15),
        ),
        StreamBuilder(
          stream: store.locationStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextFormField(
              decoration: InputDecoration(
                hintText: 'Write the city where event willl take place',
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).hintColor),
                errorText: snapshot.hasError ? snapshot.error.toString() : null,
                errorStyle: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.red),
              ),
              onChanged: store.changeLocation,
            );
          },
        ),
        const SizedBox(height: 30),
        Text(
          'When *',
          style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15),
        ),
        StreamBuilder(
          stream: store.dateStream,
          builder: (context, snapshot) {
            return TextFormField(
                readOnly: true,
                showCursor: true,
                decoration: InputDecoration(
                  hintText: datePicked == null
                      ? "dd/mm/yyyy"
                      : DateFormat('dd/MMM/yyyy').format(datePicked!),
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).hintColor),
                  errorText:
                      snapshot.hasError ? snapshot.error.toString() : null,
                  errorStyle: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.red),
                ),
                onTap: () async {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  ).then((date) {
                    setState(() {
                      datePicked = date;
                      store.changeDate(date!);
                    });
                  });
                },
                onChanged: (text) {
                  store.changeDate(datePicked!);
                });
          },
        ),
        const SizedBox(height: 30),
        Text(
          'Description *',
          style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15),
        ),
        StreamBuilder(
          stream: store.titleStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextFormField(
              decoration: InputDecoration(
                hintText: 'Write the name of the event',
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).hintColor),
                errorText: snapshot.hasError ? snapshot.error.toString() : null,
                errorStyle: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.red),
              ),
              onChanged: store.changeTitle,
            );
          },
        ),
        const SizedBox(height: 30),
        Text(
          'Event URL',
          style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15),
        ),
        StreamBuilder(
          stream: store.urlStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextFormField(
              decoration: InputDecoration(
                hintText: 'What´s your name?',
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).hintColor),
                errorText: snapshot.hasError ? snapshot.error.toString() : null,
                errorStyle: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.red),
              ),
              onChanged: store.changeUrl,
            );
          },
        ),
        Text(
          'Link to a page Whwrw attendees can RSVP; get notificatons; see who else is coming; and check the date, time, and, adress.',
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 13, color: Theme.of(context).hintColor),
        ),
      ],
    );
  }
}
