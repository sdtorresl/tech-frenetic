import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/common/alert_dialog.dart';
import 'package:techfrenetic/app/modules/create_groups/create_groups_controller.dart';

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

class _CreateGroupsPageState
    extends ModularState<CreateGroupsPage, CreateGroupsController> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
                          child: StreamBuilder(
                              stream: store.formValidStream,
                              builder: (context, snapshot) {
                                return ElevatedButton(
                                  onPressed: snapshot.hasData && !_isLoading
                                      ? () async {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          bool created =
                                              await store.createGroup();
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          if (created) {
                                            Widget content = const Text(
                                                'Grupo exitosamente creado');
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
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ];
                                            showMessage(context,
                                                title: '',
                                                content: content,
                                                actions: actions);
                                          } else {
                                            Widget content = Text(
                                                AppLocalizations.of(context)!
                                                    .error_group_api);
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
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ];
                                            showMessage(context,
                                                title: AppLocalizations.of(
                                                        context)!
                                                    .error,
                                                content: content,
                                                actions: actions);
                                          }
                                        }
                                      : null,
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
                                );
                              }),
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
          StreamBuilder(
              stream: store.nameStream,
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
                  onChanged: store.changeName,
                );
              }),
          const SizedBox(height: 40),
          StreamBuilder(
              stream: store.descriptionStream,
              builder: (context, snapshot) {
                return TextFormField(
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
                  onChanged: store.changeDescription,
                );
              }),
          const SizedBox(height: 40),
          StreamBuilder(
              stream: store.rulesStream,
              builder: (context, snapshot) {
                return TextFormField(
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
                  onChanged: store.changeRules,
                );
              }),
          const SizedBox(height: 60),
          Text(
            AppLocalizations.of(context)!.group_person,
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15),
          ),
          StreamBuilder(
              stream: store.namePersonStream,
              builder: (context, snapshot) {
                return TextFormField(
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
                  onChanged: store.changeNamePerson,
                );
              }),
          const SizedBox(height: 60),
          Text(
            AppLocalizations.of(context)!.select,
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15),
          ),
          StreamBuilder(
              stream: store.typeStream,
              builder: (context, snapshot) {
                store.changeType(defaultValue!);
                return DropdownButton<String>(
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
                        store.changeType(defaultValue!);
                        debugPrint(defaultValue);
                      },
                    );
                  },
                );
              }),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
