import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/providers/articles_provider.dart';
import 'package:techfrenetic/app/common/icons.dart';
import 'package:techfrenetic/app/widgets/post_widget.dart';
import 'package:techfrenetic/app/widgets/meetups.dart';
import 'package:techfrenetic/app/widgets/groups.dart';

class CommunityPage extends StatefulWidget {
  final String title;
  const CommunityPage({Key? key, this.title = 'CommunityPage'})
      : super(key: key);
  @override
  CommunityPageState createState() => CommunityPageState();
}

class CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = <Tab>[
      Tab(
        height: 35,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  color: Theme.of(context).chipTheme.backgroundColor,
                  width: 1)),
          child: const Align(
            alignment: Alignment.center,
            child: Text("Feed"),
          ),
        ),
      ),
      Tab(
        height: 35,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  color: Theme.of(context).chipTheme.backgroundColor,
                  width: 1)),
          child: const Align(
            alignment: Alignment.center,
            child: Text("Meetups"),
          ),
        ),
      ),
      Tab(
        height: 35,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  color: Theme.of(context).chipTheme.backgroundColor,
                  width: 1)),
          child: const Align(
            alignment: Alignment.center,
            child: Text("Groups"),
          ),
        ),
      ),
    ];

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
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 5),
              child: TabBar(
                unselectedLabelColor:
                    Theme.of(context).chipTheme.backgroundColor,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).chipTheme.backgroundColor),
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
      padding: const EdgeInsets.all(15),
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
              offset: const Offset(0.5, 0.5),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Share an update'),
                    GestureDetector(
                      child: const Icon(
                        TechFreneticIcons.article,
                        size: 20,
                      ),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Container(
                        color: Colors.amberAccent,
                        child: const Icon(
                          TechFreneticIcons.shareVideo,
                          size: 20,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
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
    ArticlesProvider _articlesProvideer = ArticlesProvider();

    return FutureBuilder(
      future: _articlesProvideer.getRelatedArticles(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ArticlesModel>> snapshot) {
        if (snapshot.hasData) {
          List<ArticlesModel> articles = snapshot.data ?? [];
          List<Widget> postsWidgets = [];

          for (ArticlesModel article in articles) {
            debugPrint(article.title.toString());
            postsWidgets.add(PostWidget(
              article: article,
            ));
          }

          return ListView(
            shrinkWrap: true,
            children: [
              _postbox(),
              ...postsWidgets,
              const SizedBox(
                height: 60,
              )
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _meetups() {
    return const MeetupWidget();
  }

  Widget _groups() {
    return const GroupsWidget();
  }
}
