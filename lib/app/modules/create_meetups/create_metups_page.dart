import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:techfrenetic/app/common/alert_dialog.dart';
import 'package:techfrenetic/app/core/errors.dart';
import 'package:techfrenetic/app/modules/create_meetups/create_metups_controller.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                        AppLocalizations.of(context)!.meetups_host_blue,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 30,
                              color: Theme.of(context).indicatorColor,
                            ),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.meetups_host_black,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 30),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.connect_with_other,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 16),
                ),
                Text(
                  AppLocalizations.of(context)!.in_your_area,
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
                                  Widget content = Text(
                                      AppLocalizations.of(context)!
                                          .message_meetup_created);
                                  List<Widget> actions = [
                                    TextButton(
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .close
                                            .toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .button!
                                            .copyWith(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ];
                                  showMessage(context,
                                      title:
                                          AppLocalizations.of(context)!.message,
                                      content: content,
                                      actions: actions);
                                  debugPrint('Meetup created');
                                } else {
                                  Widget content = Text(
                                      AppLocalizations.of(context)!
                                          .error_meetup_api);
                                  List<Widget> actions = [
                                    TextButton(
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .close
                                            .toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .button!
                                            .copyWith(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ];
                                  showMessage(context,
                                      title:
                                          AppLocalizations.of(context)!.error,
                                      content: content,
                                      actions: actions);
                                  debugPrint("Meetup not created");
                                }
                              }
                            : null,
                        child: Text(
                          AppLocalizations.of(context)!.cta_post,
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
          AppLocalizations.of(context)!.lbl_where + ' *',
          style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15),
        ),
        StreamBuilder(
          stream: store.locationStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextFormField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.write_the_city,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).hintColor),
                errorText: snapshot.hasError
                    ? TFError.getError(context, snapshot.error as ErrorType)
                    : null,
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
          AppLocalizations.of(context)!.lbl_when + ' *',
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
                  errorText: snapshot.hasError
                      ? TFError.getError(context, snapshot.error as ErrorType)
                      : null,
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
                      if (date != null) {
                        store.changeDate(date);
                      }
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
          AppLocalizations.of(context)!.lbl_description + ' *',
          style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15),
        ),
        StreamBuilder(
          stream: store.titleStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextFormField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.txt_description,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).hintColor),
                errorText: snapshot.hasError
                    ? TFError.getError(context, snapshot.error as ErrorType)
                    : null,
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
          AppLocalizations.of(context)!.lbl_url,
          style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15),
        ),
        StreamBuilder(
          stream: store.urlStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextFormField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.txt_link,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).hintColor),
                errorText: snapshot.hasError
                    ? TFError.getError(context, snapshot.error as ErrorType)
                    : null,
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
          AppLocalizations.of(context)!.txt_link_help,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 13, color: Theme.of(context).hintColor),
        ),
      ],
    );
  }
}
