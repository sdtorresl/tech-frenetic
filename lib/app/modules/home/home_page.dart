import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/community/community_page.dart';
import 'package:techfrenetic/app/modules/profile/profile_page.dart';
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
    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: [
              const SizedBox(width: 20),
              Image.asset('assets/img/main-logo.png', fit: BoxFit.fill),
            ],
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black)),
      endDrawer: const CustomDrawer(),
      body: _pages[_currentIndex],
      floatingActionButton: _floatingActionButton(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        store.increment();
      },
      child: const Icon(Icons.article_outlined),
    );
  }

  TitledBottomNavigationBar _bottomNavigationBar() {
    return TitledBottomNavigationBar(
      reverse: true,
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
