import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:techfrenetic/app/modules/profile/profile_store.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  final ProfileStore _profileStore = Modular.get();
  final List<String> _routes = [
    '/profile/profile',
    '/profile/content',
    '/profile/activity',
    '/profile/saved-articles',
    '/profile/my-account'
  ];

  @override
  void initState() {
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

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Observer(
              builder: (BuildContext context) {
                return GNav(
                  selectedIndex: _profileStore.index,
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
                  tabBackgroundColor:
                      Theme.of(context).chipTheme.backgroundColor!,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  tabs: tabs,
                  onTabChange: (index) {
                    _profileStore.index = index;
                    Modular.to.navigate(_routes[index]);
                  },
                );
              },
            ),
          ),
          const Expanded(
            child: RouterOutlet(),
          ),
        ],
      ),
    );
  }
}
