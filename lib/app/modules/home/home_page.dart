import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_controller.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tech Frenetic'),
      ),
      endDrawer: const Drawer(),
      body: StreamBuilder(
        stream: store.counterStream,
        builder: (context, snapshot) => Text('${snapshot.data}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          store.increment();
        },
        child: const Icon(Icons.article_outlined),
      ),
      bottomNavigationBar: TitledBottomNavigationBar(
          reverse: true,
          currentIndex: 2, // Use this to update the Bar giving a position
          onTap: (index) {
            debugPrint("Selected Index: $index");
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
          ]),
    );
  }
}
