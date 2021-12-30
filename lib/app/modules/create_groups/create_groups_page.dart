import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:techfrenetic/app/widgets/highlight_container.dart';

class CreateGroupsPage extends StatefulWidget {
  const CreateGroupsPage({Key? key}) : super(key: key);

  @override
  _CreateGroupsPageState createState() => _CreateGroupsPageState();
}

List<String> items = [
  'Private',
  'Public',
];
String? defaultValue = items.first;

class _CreateGroupsPageState extends State<CreateGroupsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
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
                  ]),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: .5, color: Colors.grey),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HighlightContainer(
                              child: Text(
                                AppLocalizations.of(context)!.tab_create,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        fontSize: 25,
                                        color: Theme.of(context).primaryColor),
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.groups,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(fontSize: 25),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Lorem impusm connect with other Tech Frenetic’s members in…',
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        IconButton(
                          icon: Icon(Icons.camera_alt_outlined,
                              color: Theme.of(context).primaryColor),
                          iconSize: 50,
                          onPressed: null,
                        ),
                        form(),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: 250,
                          child: ElevatedButton(
                            onPressed: () => {},
                            child: Text(
                              AppLocalizations.of(context)!.btn_create,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget form() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 23.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<Object>(
              stream: null, //store.nameStream,
              builder: (context, snapshot) {
                return TextFormField(
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.group_name,
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
                );
              }),
          const SizedBox(height: 40),
          TextFormField(
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.group_description,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Theme.of(context).hintColor),
              //errorText: snapshot.hasError ? snapshot.error.toString() : null,
              errorStyle: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.red),
            ),
          ),
          const SizedBox(height: 40),
          TextFormField(
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.group_rules,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Theme.of(context).hintColor),
              //errorText: snapshot.hasError ? snapshot.error.toString() : null,
              errorStyle: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.red),
            ),
          ),
          const SizedBox(height: 60),
          Text(
            AppLocalizations.of(context)!.group_person,
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.group_person,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Theme.of(context).hintColor),
              //errorText: snapshot.hasError ? snapshot.error.toString() : null,
              errorStyle: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.red),
            ),
          ),
          const SizedBox(height: 60),
          Text(
            AppLocalizations.of(context)!.select,
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15),
          ),
          DropdownButton<String>(
            value: defaultValue,
            isExpanded: true,
            underline: Container(
              height: 0.5,
              color: Colors.black,
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
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
