import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/group_model.dart';
import 'package:techfrenetic/app/providers/group_providers.dart';
import 'package:techfrenetic/app/widgets/groups_cards_widget.dart';
import 'package:techfrenetic/app/widgets/recommended_groups_widget.dart';
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
      ],
    );
  }

  Widget _recommndedGroups(BuildContext context) {
    GroupsProvider groupsProvider = GroupsProvider();

    return FutureBuilder(
      future: groupsProvider.getRecommended(),
      builder:
          (BuildContext context, AsyncSnapshot<List<GroupModel>> snapshot) {
        if (snapshot.hasData) {
          List<GroupModel> recommendedGroups = snapshot.data ?? [];
          List<Widget> recommendedGroupsWidgets =
              getRecommendedGroupsWidget(recommendedGroups, context);

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    AppLocalizations.of(context)!.community_groups_maylike,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 20,
                        ),
                  ),
                ),
                ...recommendedGroupsWidgets,
                const SizedBox(height: 60),
              ],
            ),
          );
        } else {
          return const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  List<Widget> getRecommendedGroupsWidget(
      List<GroupModel> recommendedGroups, BuildContext context) {
    double separatorWidth = MediaQuery.of(context).size.width * 0.8;
    List<Widget> recommendedGroupsWidgets = [];

    for (var i = 0; i < recommendedGroups.length; i++) {
      GroupModel group = recommendedGroups[i];
      if (i < 3) {
        recommendedGroupsWidgets.add(
          GroupWidget(group: group),
        );
        if (i != 2) {
          recommendedGroupsWidgets.add(
            Separator(separatorWidth: separatorWidth),
          );
        } else {
          recommendedGroupsWidgets.add(
            Separator(
              separatorWidth: separatorWidth,
              color: Theme.of(context).unselectedWidgetColor,
              margin: const EdgeInsets.symmetric(vertical: 5),
              height: 0.5,
            ),
          );
        }
      } else {
        recommendedGroupsWidgets.add(
          GroupsCardsWidget(
            group: group,
          ),
        );
        recommendedGroupsWidgets.add(
          Separator(
            separatorWidth: separatorWidth,
            color: Theme.of(context).unselectedWidgetColor,
            margin: const EdgeInsets.symmetric(vertical: 5),
            height: 0.5,
          ),
        );
      }
    }
    return recommendedGroupsWidgets;
  }
}
