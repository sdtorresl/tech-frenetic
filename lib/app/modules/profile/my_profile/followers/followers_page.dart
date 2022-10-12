import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/widgets/separator.dart';
import 'package:techfrenetic/app/widgets/user_item_widget.dart';

class FollowersPage extends StatelessWidget {
  final List<UserModel> following;
  final List<UserModel> followers;

  const FollowersPage(
      {Key? key, required this.following, required this.followers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TFAppBar(
          title: Text(
            AppLocalizations.of(context)!.my_profile,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      "${AppLocalizations.of(context)!.profile_following} (${following.length})",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "${AppLocalizations.of(context)!.profile_followers} (${followers.length})",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _listUsers(following),
                  _listUsers(followers),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listUsers(List<UserModel> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        double width = MediaQuery.of(context).size.width - 40;
        return Column(
          children: [
            UserItemWidget(
              user: users[index],
            ),
            Separator(
              separatorWidth: width,
              color: Theme.of(context).dividerColor,
            )
          ],
        );
      },
    );
  }
}
