import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/common/icons.dart';
import 'package:techfrenetic/app/core/user_preferences.dart';
import 'package:techfrenetic/app/modules/articles/add_articles_page.dart';
import 'package:techfrenetic/app/modules/home/home_store.dart';
import 'package:techfrenetic/app/modules/profile/profile_store.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';
import 'package:techfrenetic/app/widgets/avatar_widget.dart';
import 'package:techfrenetic/app/widgets/expandable_fab.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:techfrenetic/app/widgets/drawer_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  final List<String> _pages = [
    '/community',
    '/skills',
    '/vendors',
    '/profile/profile'
  ];
  final prefs = UserPreferences();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                store.selectedPage = 0;
                Modular.to.navigate(_pages[store.selectedPage]);
              },
              child: Image.asset('assets/img/main-logo.png', fit: BoxFit.fill),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          _searchMenu(),
          _userMenu(),
          _openDrawer(_scaffoldKey),
        ],
      ),
      endDrawer: CustomDrawer(),
      body: RouterOutlet(),
      floatingActionButton: _floatingActionButton(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _openDrawer(GlobalKey<ScaffoldState> _scaffoldKey) {
    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {
        _scaffoldKey.currentState!.openEndDrawer();
      },
    );
  }

  Widget _searchMenu() {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {
        Modular.to.pushNamed('/search');
      },
    );
  }

  Widget _userMenu() {
    return PopupMenuButton(
      child: Container(
        width: 50,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: AvatarWidget(
          userId: prefs.userId!,
        ),
      ),
      offset: const Offset(0, 60),
      color: Colors.white,
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: Text(
            AppLocalizations.of(context)!.notification_button,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        PopupMenuItem<int>(
          onTap: () {
            ProfileStore profileStore = Modular.get();
            profileStore.index = 0;
            store.selectedPage = 3;
            Modular.to.navigate('/profile/profile');
          },
          value: 1,
          child: Text(
            AppLocalizations.of(context)!.profile,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Text(
            AppLocalizations.of(context)!.logout_button,
            style: const TextStyle(color: Colors.black),
          ),
          onTap: () async {
            UserProvider userProvider = UserProvider();
            await userProvider.logout();
            Modular.to.popAndPushNamed("/login");
          },
        ),
      ],
      onSelected: (item) => {
        debugPrint(
          item.toString(),
        ),
      },
    );
  }

  Widget _floatingActionButton() {
    List<Widget> actions = [
      ActionButton(
        onPressed: () {
          Modular.to.pushNamed("/community/video");
        },
        icon: const Icon(TechFreneticIcons.shareVideo),
      ),
      ActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddArticlesPage();
            },
          );
        },
        icon: const Icon(TechFreneticIcons.article),
      ),
    ];

    return ExpandableFab(
      distance: 70.0,
      children: actions,
    );
  }

  Widget _bottomNavigationBar() {
    return Observer(
      builder: (context) => TitledBottomNavigationBar(
        reverse: true,
        currentIndex: store.selectedPage,
        onTap: (index) {
          store.selectedPage = index;
          debugPrint("Selected page: ${store.selectedPage}");
          Modular.to.navigate(_pages[store.selectedPage]);
        },
        curve: Curves.easeInBack,
        items: [
          TitledNavigationBarItem(
              title: Text(AppLocalizations.of(context)!.community),
              icon: const Icon(Icons.people_alt_outlined)),
          TitledNavigationBarItem(
              title: Text(AppLocalizations.of(context)!.skills),
              icon: const Icon(Icons.home)),
          TitledNavigationBarItem(
              title: Text(AppLocalizations.of(context)!.vendors),
              icon: const Icon(Icons.card_travel)),
          TitledNavigationBarItem(
              title: Text(AppLocalizations.of(context)!.profile),
              icon: const Icon(Icons.person_outline)),
        ],
      ),
    );
  }
}
