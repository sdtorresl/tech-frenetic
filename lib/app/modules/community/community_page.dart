import 'package:flutter/material.dart';
import 'package:techfrenetic/app/widgets/post_widget.dart';

class CommunityPage extends StatefulWidget {
  final String title;
  const CommunityPage({Key? key, this.title = 'CommunityPage'})
      : super(key: key);
  @override
  CommunityPageState createState() => CommunityPageState();
}

class CommunityPageState extends State<CommunityPage> {
  final List<Tab> tabs = <Tab>[
    const Tab(text: 'Feed'),
    const Tab(text: 'Meetups'),
    const Tab(text: 'Groups'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      // The Builder widget is used to have a different BuildContext to access
      // closest DefaultTabController.
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            // Your code goes here.
            // To get index of current tab use tabController.index
          }
        });
        return Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              child: TabBar(
                tabs: tabs,
              ),
            ),
            Expanded(
              child: TabBarView(children: [
                _feeds(),
                _meetups(),
                _groups(),
              ]),
            ),
          ],
        );
      }),
    );
  }

  Widget _feeds() {
    return ListView(
      children: const [
        PostWidget(),
        PostWidget(),
        PostWidget(),
        PostWidget(),
        PostWidget(),
        PostWidget(),
        PostWidget(),
        PostWidget(),
        PostWidget(),
      ],
    );
  }

  Widget _meetups() {
    return const Text("Meetups");
  }

  Widget _groups() {
    return const Text("Groups");
  }
}
