import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/common/icons.dart';
import 'package:techfrenetic/app/core/user_preferences.dart';
import 'package:techfrenetic/app/modules/articles/add_articles_page.dart';
import 'package:techfrenetic/app/widgets/avatar_widget.dart';
import 'package:techfrenetic/app/widgets/expandable_fab.dart';
import 'home_controller.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:techfrenetic/app/widgets/drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  final List<String> _pages = ['/community', '/skills', '/vendors', '/profile'];
  final prefs = UserPreferences();

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
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
                setState(() {
                  _currentIndex = 0;
                });
                Modular.to.navigate(_pages[0]);
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
      endDrawer: CustomDrawer(callback: _updateChildPage),
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
          onTap: () => Modular.to.pushNamed('/profile'),
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
    return TitledBottomNavigationBar(
      reverse: true,
      currentIndex:
          _currentIndex, // Use this to update the Bar giving a position
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        Modular.to.navigate(_pages[index]);
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
    );
  }

  _updateChildPage(String route) {
    debugPrint("Updating index");
    int index = _pages.contains(route) ? _pages.indexOf(route) : 0;
    setState(() {
      _currentIndex = index;
    });
    Modular.to.navigate(_pages[0]);
  }
}
