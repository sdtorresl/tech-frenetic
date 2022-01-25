import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/my_groups/my_groups_page.dart';
import 'package:techfrenetic/app/modules/discover_groups/discover_groups_page.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TabBar(
          tabs: [
            Tab(
              child: Text(AppLocalizations.of(context)!.tab_discover,
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            Tab(
              child: Text(AppLocalizations.of(context)!.tab_groups,
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            Tab(
              child: GestureDetector(
                onTap: () =>
                    Modular.to.pushNamed("/community/groups/create_groups"),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 20,
                        child: Text(
                          AppLocalizations.of(context)!.tab_create,
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            const DiscoverGroupsPage(),
            const MyGroupPage(),
            Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => Modular.to
                            .pushNamed("/community/groups/create_groups"),
                        child: Text(
                          AppLocalizations.of(context)!.tab_create,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
