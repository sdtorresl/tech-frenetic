import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/common/alert_dialog.dart';
import 'package:techfrenetic/app/core/errors.dart';
import 'package:techfrenetic/app/modules/articles/widgets/image_selection_widget.dart';
import 'package:techfrenetic/app/modules/create_groups/create_groups_controller.dart';

import 'package:techfrenetic/app/widgets/highlight_container.dart';

class CreateGroupsPage extends StatefulWidget {
  const CreateGroupsPage({Key? key}) : super(key: key);

  @override
  _CreateGroupsPageState createState() => _CreateGroupsPageState();
}

class _CreateGroupsPageState
    extends ModularState<CreateGroupsPage, CreateGroupsController> {
  Map<bool, String> items = {true: 'Public', false: 'Private'};
  bool _isLoading = false;

  @override
  void initState() {
    store.changeType(true);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    items = {
      true: AppLocalizations.of(context)!.groups_public,
      false: AppLocalizations.of(context)!.groups_private,
    };
    super.didChangeDependencies();
  }

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
                    padding: const EdgeInsets.symmetric(
                      vertical: 50,
                      horizontal: 20,
                    ),
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
                          AppLocalizations.of(context)!.group_intro,
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.center,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageSelectionWidget(
          onImageLoaded: (image) {
            if (image != null) {
              store.changeImage(image);
            }
          },
        ),
        const SizedBox(
          height: 10,
        ),
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
                  errorText: snapshot.hasError
                      ? TFError.getError(context, snapshot.error as ErrorType)
                      : null,
                  errorStyle: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.red),
                ),
                onChanged: store.changeName,
              );
            }),
        const SizedBox(height: 20),
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
                  errorText: snapshot.hasError
                      ? TFError.getError(context, snapshot.error as ErrorType)
                      : null,
                  errorStyle: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.red),
                ),
                onChanged: store.changeDescription,
              );
            }),
        const SizedBox(height: 20),
        StreamBuilder(
            stream: store.rulesStream,
            builder: (context, snapshot) {
              return TextFormField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.groups_rules,
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
                onChanged: store.changeRules,
              );
            }),
        const SizedBox(height: 30),
        Text(
          AppLocalizations.of(context)!.group_person,
          style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15),
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
                  errorText: snapshot.hasError
                      ? TFError.getError(context, snapshot.error as ErrorType)
                      : null,
                  errorStyle: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.red),
                ),
                onChanged: store.changeNamePerson,
              );
            }),
        const SizedBox(height: 30),
        Text(
          AppLocalizations.of(context)!.select,
          style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15),
        ),
        StreamBuilder(
            stream: store.isPublicStream,
            builder: (context, snapshot) {
              return DropdownButton<bool>(
                value: store.isPublic,
                isExpanded: true,
                underline: Container(
                  height: 0.5,
                  color: Colors.black,
                ),
                items: items.entries.map(
                  (e) {
                    return DropdownMenuItem<bool>(
                      child: Text(e.value),
                      value: e.key,
                    );
                  },
                ).toList(),
                onChanged: (isPublic) {
                  setState(
                    () {
                      store.changeType(isPublic ?? true);
                    },
                  );
                },
              );
            }),
        const SizedBox(height: 60),
      ],
    );
  }
}
