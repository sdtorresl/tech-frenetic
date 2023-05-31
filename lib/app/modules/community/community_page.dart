import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/modules/community/widgets/feeds_widget.dart';
import 'package:techfrenetic/app/modules/meetups/meetups_page.dart';
import 'package:techfrenetic/app/modules/groups/groups_page.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  CommunityPageState createState() => CommunityPageState();
}

class CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = <Tab>[
      Tab(
        height: 35,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  color: Theme.of(context).chipTheme.backgroundColor!,
                  width: 1)),
          child: Align(
            alignment: Alignment.center,
            child: Text(AppLocalizations.of(context)!.feed),
          ),
        ),
      ),
      Tab(
        height: 35,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  color: Theme.of(context).chipTheme.backgroundColor!,
                  width: 1)),
          child: Align(
            alignment: Alignment.center,
            child: Text(AppLocalizations.of(context)!.meetups),
          ),
        ),
      ),
      Tab(
        height: 35,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  color: Theme.of(context).chipTheme.backgroundColor!,
                  width: 1)),
          child: Align(
            alignment: Alignment.center,
            child: Text(AppLocalizations.of(context)!.groups),
          ),
        ),
      ),
    ];

    return DefaultTabController(
      length: tabs.length,
      // The Builder widget is used to have a different BuildContext to access
      // closest DefaultTabController.
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            // Your code goes here.
            // To get index of current tab use tabController.index
          }
        });
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 5),
                child: TabBar(
                  unselectedLabelColor:
                      Theme.of(context).chipTheme.backgroundColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).chipTheme.backgroundColor),
                  tabs: tabs,
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  const FeedsWidget(),
                  _meetups(),
                  _groups(),
                ]),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _meetups() {
    return const MetupsPage();
  }

  Widget _groups() {
    return const GroupsPage();
  }
}
