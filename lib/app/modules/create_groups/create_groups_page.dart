import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:techfrenetic/app/modules/create_groups/create_groups_controller.dart';

class CreateGroupsPage extends StatefulWidget {
  const CreateGroupsPage({Key? key}) : super(key: key);

  @override
  _CreateGroupsPageState createState() => _CreateGroupsPageState();
}

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
                            child: const Text(
                              'Create group',
                              style: TextStyle(
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
                    hintText: 'Write the group name',
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
              hintText: 'Write the group name',
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
              hintText: 'Write short description group name',
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
              hintText: 'Group rules',
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
            'Write the name of person',
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Write the name of person',
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
        ],
      ),
    );
  }
}
