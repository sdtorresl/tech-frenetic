import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  final String title;
  const ProfilePage({Key? key, this.title = 'ProfilePage'}) : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final List<GButton> tabs = <GButton>[
      GButton(
        icon: Icons.person,
        text: AppLocalizations.of(context)!.my_profile,
      ),
      GButton(
        icon: Icons.article_rounded,
        text: AppLocalizations.of(context)!.my_content,
      ),
      GButton(
        icon: Icons.local_activity,
        text: AppLocalizations.of(context)!.my_activity,
      ),
      GButton(
        icon: Icons.save,
        text: AppLocalizations.of(context)!.saved_articles,
      ),
      GButton(
        icon: Icons.manage_accounts,
        text: AppLocalizations.of(context)!.my_account,
      ),
    ];

    return DefaultTabController(
      length: tabs.length,
      // The Builder widget is used to have a different BuildContext to access
      // closest DefaultTabController.
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: GNav(
                tabBorderRadius: 50,
                tabActiveBorder: Border.all(
                  color: Theme.of(context).chipTheme.backgroundColor,
                  width: 1,
                ),
                tabBorder: Border.all(color: Colors.transparent, width: 0),
                duration: const Duration(milliseconds: 200),
                gap: 8,
                color: Theme.of(context).chipTheme.labelStyle.color,
                activeColor: Colors.white,
                iconSize: 24,
                tabBackgroundColor: Theme.of(context).chipTheme.backgroundColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                tabs: tabs,
                onTabChange: (index) => tabController.animateTo(index),
              ),
            ),
            Expanded(
              child: TabBarView(children: [
                _myProfile(context),
                _myContent(context),
                _myActivity(context),
                _savedArticles(context),
                _myAccount(context)
              ]),
            ),
          ],
        );
      }),
    );
  }

  Widget _myProfile(BuildContext context) {
    return Text(AppLocalizations.of(context)!.my_profile);
  }

  Widget _myContent(BuildContext context) {
    return Text(AppLocalizations.of(context)!.my_content);
  }

  Widget _myActivity(BuildContext context) {
    return Text(AppLocalizations.of(context)!.my_activity);
  }

  Widget _savedArticles(BuildContext context) {
    return Text(AppLocalizations.of(context)!.saved_articles);
  }

  Widget _myAccount(BuildContext context) {
    return Text(AppLocalizations.of(context)!.my_account);
  }
}
