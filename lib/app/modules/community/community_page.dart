import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/modules/community/widgets/stories_view_widget.dart';
import 'package:techfrenetic/app/modules/meetups/meetups_page.dart';
import 'package:techfrenetic/app/providers/articles_provider.dart';
import 'package:techfrenetic/app/widgets/post_widget.dart';
import 'package:techfrenetic/app/modules/groups/groups_page.dart';
import 'package:techfrenetic/app/modules/posts/post_box_widget.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

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
                  color: Theme.of(context).chipTheme.backgroundColor!,
                  width: 1)),
          child: Align(
            alignment: Alignment.center,
            child: Text(AppLocalizations.of(context)!.feed),
          ),
        ),
      ),
      Tab(
        height: 35,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  color: Theme.of(context).chipTheme.backgroundColor!,
                  width: 1)),
          child: Align(
            alignment: Alignment.center,
            child: Text(AppLocalizations.of(context)!.meetups),
          ),
        ),
      ),
      Tab(
        height: 35,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  color: Theme.of(context).chipTheme.backgroundColor!,
                  width: 1)),
          child: Align(
            alignment: Alignment.center,
            child: Text(AppLocalizations.of(context)!.groups),
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
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
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
          ),
        );
      }),
    );
  }

  Widget _feeds() {
    ArticlesProvider _articlesProvider = ArticlesProvider();

    return FutureBuilder(
      future: _articlesProvider.getWall(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ArticlesModel>> snapshot) {
        if (snapshot.hasData) {
          List<ArticlesModel> articles = snapshot.data ?? [];
          List<Widget> postsWidgets = [];

          for (ArticlesModel article in articles) {
            postsWidgets.add(PostWidget(article: article));
          }

          return ListView(
            shrinkWrap: true,
            children: [
              PostBoxWidget(
                onPostLoaded: () {
                  setState(() {});
                },
                onArticleLoaded: (id) {
                  debugPrint("El id de artículo es: $id");
                },
              ),
              const StoriesViewWidget(),
              ...postsWidgets,
              const SizedBox(height: 60),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _meetups() {
    return const MetupsPage();
  }

  Widget _groups() {
    return const GroupsPage();
  }
}
