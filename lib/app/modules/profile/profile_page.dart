import 'package:flutter_modular/flutter_modular.dart';

import 'my_account/my_account_page.dart';
import 'my_content/my_content_page.dart';
import 'my_profile/my_profile_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';
import 'package:techfrenetic/app/modules/profile/my_activity/my_activity_page.dart';
import 'package:techfrenetic/app/modules/profile/saved_articles/my_saved_articles_page.dart';

class ProfilePage extends StatefulWidget {
  final String title;

  const ProfilePage({
    Key? key,
    this.title = 'ProfilePage',
  }) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late final TabController _controller;

  final List<String> _routes = [
    '/profile/profile',
    '/profile/content',
    '/profile/activity',
    '/profile/saved-articles',
    '/profile/my-account'
  ];

  @override
  void initState() {
    _controller = TabController(length: _routes.length, vsync: this);
    super.initState();
  }

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
        text: AppLocalizations.of(context)!.my_articles,
      ),
      GButton(
        icon: Icons.manage_accounts,
        text: AppLocalizations.of(context)!.my_account,
      ),
    ];

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          child: GNav(
            selectedIndex: _controller.index,
            tabBorderRadius: 50,
            tabActiveBorder: Border.all(
              color: Theme.of(context).chipTheme.backgroundColor!,
              width: 1,
            ),
            tabBorder: Border.all(color: Colors.transparent, width: 0),
            duration: const Duration(milliseconds: 200),
            gap: 8,
            color: Theme.of(context).chipTheme.labelStyle!.color!,
            activeColor: Colors.white,
            iconSize: 24,
            tabBackgroundColor: Theme.of(context).chipTheme.backgroundColor!,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            tabs: tabs,
            onTabChange: (index) {
              _controller.index = index;
              Modular.to.navigate(_routes[index],
                  arguments: {'callback': changeSelectedPage});
            },
          ),
        ),
        Expanded(
          child: RouterOutlet(),
        ),
      ],
    );
  }

  void changeSelectedPage(String route) {
    debugPrint("Changing route $route");
    int index = _routes.contains(route) ? _routes.indexOf(route) : 0;
    debugPrint("New index = $index");

    setState(() {
      _controller.index = index;
    });
  }
}
