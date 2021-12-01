import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/widgets/recommended_groups_widget.dart';

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
                        fontSize: 25,
                      ),
                ),
                RecommendedGroupsWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
