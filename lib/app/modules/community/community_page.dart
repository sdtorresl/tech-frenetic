import 'package:flutter/material.dart';
import 'package:techfrenetic/app/widgets/post_widget.dart';
import 'package:techfrenetic/app/widgets/meetups.dart';

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

  Widget _postbox() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              width: 1.90,
              color: Theme.of(context).primaryColor,
            ),
            left: BorderSide(
              width: 0.50,
              color: Colors.grey.withOpacity(.6),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).unselectedWidgetColor,
              spreadRadius: -3,
              blurRadius: 5,
              offset: Offset(0.5, 0.5),
            )
          ],
        ),
        child: Card(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(children: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Share an update'),
                  ),
                  SizedBox(
                    width: 110,
                  ),
                  Icon(Icons.videocam),
                  SizedBox(
                    width: 30,
                  ),
                  //Icon(Icons.mode_edit_outline_sharp),
                ],
              ),
              TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    //focusedBorder: InputBorder.none,
                    //disabledBorder: InputBorder.none,
                    hintText: "Write something...",
                    hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                    prefixIcon: Icon(
                      Icons.account_circle,
                      color: Theme.of(context).splashColor,
                    )),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _feeds() {
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(
          height: 20,
        ),
        _postbox(),
        const PostWidget(),
        const PostWidget(),
        const PostWidget(),
        const PostWidget(),
        const PostWidget(),
        const PostWidget(),
        const PostWidget(),
        const PostWidget(),
        const PostWidget(),
      ],
    );
  }

  Widget _meetups() {
    return MeetupWidget();
  }

  Widget _groups() {
    return const Text("Groups");
  }
}
