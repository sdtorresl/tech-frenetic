import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/group_model.dart';
import 'package:techfrenetic/app/providers/group_providers.dart';

import 'package:techfrenetic/app/widgets/recommended_groups_widget.dart';
import 'package:techfrenetic/app/widgets/groups_cards_widget.dart';
import 'package:techfrenetic/app/widgets/separator.dart';

class DiscoverGroupsPage extends StatefulWidget {
  const DiscoverGroupsPage({Key? key}) : super(key: key);

  @override
  _DiscoverGroupsPageState createState() => _DiscoverGroupsPageState();
}

class _DiscoverGroupsPageState extends State<DiscoverGroupsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _recommndedGroups(context),
        Center(
          child: Container(
            color: Theme.of(context).unselectedWidgetColor,
            width: 400,
            height: .5,
          ),
        ),
        const SizedBox(height: 30),
        const GroupsCardsWidget(),
        const SizedBox(height: 10),
        Center(
          child: Container(
            color: Theme.of(context).unselectedWidgetColor,
            width: 300,
            height: .5,
          ),
        ),
        const SizedBox(height: 10),
        const GroupsCardsWidget(),
        const SizedBox(height: 10),
        Center(
          child: Container(
            color: Theme.of(context).unselectedWidgetColor,
            width: 300,
            height: .5,
          ),
        ),
        const SizedBox(height: 10),
        const GroupsCardsWidget(),
        const SizedBox(height: 10),
        Center(
          child: Container(
            color: Theme.of(context).unselectedWidgetColor,
            width: 300,
            height: .5,
          ),
        ),
        const SizedBox(height: 10),
        const GroupsCardsWidget(),
        const SizedBox(height: 10),
        Center(
          child: Container(
            color: Theme.of(context).unselectedWidgetColor,
            width: 300,
            height: .5,
          ),
        ),
        const SizedBox(height: 10),
        const GroupsCardsWidget(),
        const SizedBox(height: 10),
        Center(
          child: Container(
            color: Theme.of(context).unselectedWidgetColor,
            width: 300,
            height: .5,
          ),
        ),
        const SizedBox(height: 10),
        const GroupsCardsWidget(),
        const SizedBox(height: 10),
        Center(
          child: Container(
            color: Theme.of(context).unselectedWidgetColor,
            width: 300,
            height: .5,
          ),
        ),
        const SizedBox(height: 60),
      ],
    );
  }

  Widget _recommndedGroups(BuildContext context) {
    double separatorWidth = MediaQuery.of(context).size.width * 0.8;

    GroupsProvider groupsProvider = GroupsProvider();

    return FutureBuilder(
      future: groupsProvider.getRecommended(),
      builder:
          (BuildContext context, AsyncSnapshot<List<GroupModel>> snapshot) {
        if (snapshot.hasData) {
          List<Widget> recommendedGroupsWidgets = [];
          List<GroupModel> recommendedGroups = snapshot.data ?? [];

          for (GroupModel group in recommendedGroups) {
            recommendedGroupsWidgets.add(
              GroupWidget(group: group),
            );
            recommendedGroupsWidgets.add(
              Separator(separatorWidth: separatorWidth),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      'Groups you may like',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 20,
                          ),
                    ),
                  ),
                  ...recommendedGroupsWidgets
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
