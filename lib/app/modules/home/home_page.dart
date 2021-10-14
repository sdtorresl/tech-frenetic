import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/community/community_page.dart';
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
    const Text("Profile")
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

          title: Expanded(
            child: Row(
              children: [
                SizedBox(width: 60),
                Image.asset('assets/images/main-logo.png',
                    width: 140, height: 50, fit: BoxFit.fill),
              ],
            ),
          ),


          //     Row(
          //   children: [
          //     SizedBox(
          //       width: 20,
          //     ),
          //     Column(
          //       children: [
          //         Row(
          //           children: [
          //             SizedBox(
          //               width: 30,
          //             ),
          //             Text('Tech',
          //                 style: TextStyle(
          //                     fontWeight: FontWeight.w700,
          //                     fontSize: 20,
          //                     fontFamily: 'NunitoSans',
          //                     color: Color.fromRGBO(5, 20, 47, 1))),
          //           ],
          //         ),
          //         Text('Frenetic',
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w700,
          //                 fontSize: 20,
          //                 fontFamily: 'NunitoSans',
          //                 color: Color.fromRGBO(
          //                   0,
          //                   110,
          //                   232,
          //                   1,
          //                 ))),
          //       ],
          //     ),
          //     SizedBox(
          //       width: 32,
          //       height: 32,
          //       child: Image.asset('assets/images/main-logo.png'),
          //     )
          //   ],
          // ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black)),
      endDrawer: const CustomDrawer(),
      body: AnimatedContainer(
        duration: const Duration(seconds: 10),
        child: _pages[_currentIndex],
      ),
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
