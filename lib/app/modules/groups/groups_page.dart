import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/modules/my_groups/my_groups_page.dart';
import 'package:techfrenetic/app/modules/create_groups/create_groups_page.dart';
import 'package:techfrenetic/app/modules/discover_groups/discover_groups_page.dart';

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
              child: Text(AppLocalizations.of(context)!.tab_create,
                  style: Theme.of(context).textTheme.bodyText2),
            )
          ],
        ),
        body: const TabBarView(
          children: [
            DiscoverGroupsPage(),
            MyGroupPage(),
            CreateGroupsPage(),
          ],
        ),
      ),
    );
  }
}
