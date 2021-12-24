import 'package:flutter/material.dart';

import 'package:techfrenetic/app/widgets/recommended_groups_widget.dart';
import 'package:techfrenetic/app/widgets/groups_cards_widget.dart';

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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Groups you may like',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 20,
                      ),
                ),
                const RecommendedGroupsWidget(),
                Center(
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    width: 290,
                    height: 1.5,
                  ),
                ),
                const RecommendedGroupsWidget(),
                Center(
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    width: 290,
                    height: 1.5,
                  ),
                ),
                const RecommendedGroupsWidget(),
              ],
            ),
          ),
        ),
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
}
