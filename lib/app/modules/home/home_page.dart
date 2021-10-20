import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techfrenetic/app/modules/community/community_page.dart';
import 'package:techfrenetic/app/modules/profile/profile_page.dart';
import 'package:techfrenetic/app/widgets/expandable_fab.dart';
import 'home_controller.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:techfrenetic/app/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  final List<Widget> _pages = [
    const CommunityPage(),
    const Text("Skills"),
    const Text("Vendors"),
    const ProfilePage()
  ];

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
        actions: [_searchMenu(), _userMenu(), _openDrawer(_scaffoldKey)],
      ),
      endDrawer: const CustomDrawer(),
      body: _pages[_currentIndex],
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
            icon: const Icon(Icons.videocam),
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
            icon: const Icon(Icons.document_scanner),
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
      curve: Curves.decelerate,
      currentIndex:
          _currentIndex, // Use this to update the Bar giving a position
      onTap: (index) {
        debugPrint("Selected Index: $index");
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        TitledNavigationBarItem(
            title: const Text('Community'),
            icon: const Icon(Icons.people_alt_outlined)),
        TitledNavigationBarItem(
            title: const Text('Skills'), icon: const Icon(Icons.home)),
        TitledNavigationBarItem(
            title: const Text('T. Vendors'),
            icon: const Icon(Icons.card_travel)),
        TitledNavigationBarItem(
            title: const Text('Profile'),
            icon: const Icon(Icons.person_outline)),
      ],
    );
  }
}
