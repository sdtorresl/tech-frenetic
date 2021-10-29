import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techfrenetic/app/common/icons.dart';
import 'package:techfrenetic/app/widgets/expandable_fab.dart';
import 'home_controller.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:techfrenetic/app/widgets/drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  final List<String> _pages = ['/community', '/skills', '/vendors', '/profile'];

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
            Image.asset('assets/img/main-logo.png', fit: BoxFit.fill),
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
      endDrawer: const CustomDrawer(),
      body: AnimatedContainer(
        duration: const Duration(seconds: 10),
        child: RouterOutlet(),
      ),
      floatingActionButton: _floatingActionButton(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  IconButton _openDrawer(GlobalKey<ScaffoldState> _scaffoldKey) {
    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {
        _scaffoldKey.currentState!.openEndDrawer();
      },
    );
  }

  PopupMenuButton<int> _searchMenu() {
    return PopupMenuButton(
      icon: const Icon(Icons.search),
      color: Colors.blue,
      itemBuilder: (context) => [
        const PopupMenuItem<int>(
          value: 0,
          child: Text(
            "Setting",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
      onSelected: (item) => {debugPrint(item.toString())},
    );
  }

  PopupMenuButton<int> _userMenu() {
    return PopupMenuButton(
      child: Container(
        width: 50,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: CircleAvatar(
          child: ClipOval(
            child: SvgPicture.asset(
              'assets/img/avatars/avatar-01.svg',
              semanticsLabel: 'Acme Logo',
            ),
          ),
          radius: 20,
          backgroundColor: Colors.grey[200],
        ),
      ),
      offset: const Offset(0, 60),
      color: Colors.white,
      itemBuilder: (context) => [
        const PopupMenuItem<int>(
          value: 0,
          child: Text(
            "Notifications",
            style: TextStyle(color: Colors.black),
          ),
        ),
        const PopupMenuItem<int>(
          value: 1,
          child: Text(
            "Profile",
            style: TextStyle(color: Colors.black),
          ),
        ),
        const PopupMenuItem<int>(
          value: 2,
          child: Text(
            "Logout",
            style: TextStyle(color: Colors.black),
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
      Column(
        children: [
          ActionButton(
            onPressed: () {
              debugPrint("Action pressed");
            },
            icon: const Icon(TechFreneticIcons.shareVideo),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Share a video",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 15,
                  color: Colors.white,
                ),
          ),
        ],
      ),
      Column(
        children: [
          ActionButton(
            onPressed: () {
              debugPrint("Action pressed");
            },
            icon: const Icon(TechFreneticIcons.article),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Share an article",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 15,
                  color: Colors.white,
                ),
          ),
        ],
      ),
    ];

    return ExpandableFab(
      distance: 95.0,
      children: actions,
    );
  }

  TitledBottomNavigationBar _bottomNavigationBar() {
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
}
