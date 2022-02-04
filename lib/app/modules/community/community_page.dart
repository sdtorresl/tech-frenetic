import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/modules/articles/add_articles_page.dart';
import 'package:techfrenetic/app/modules/community/community_controller.dart';
import 'package:techfrenetic/app/modules/meetups/meetups_page.dart';
import 'package:techfrenetic/app/providers/articles_provider.dart';
import 'package:techfrenetic/app/common/icons.dart';
import 'package:techfrenetic/app/widgets/post_widget.dart';
import 'package:techfrenetic/app/modules/groups/groups_page.dart';

class CommunityPage extends StatefulWidget {
  final String title;
  const CommunityPage({Key? key, this.title = 'CommunityPage'})
      : super(key: key);
  @override
  CommunityPageState createState() => CommunityPageState();
}

class CommunityPageState
    extends ModularState<CommunityPage, CommunityController> {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.share_an_update,
                  ),
                  GestureDetector(
                    child: const Icon(
                      TechFreneticIcons.article,
                      size: 20,
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AddArticlesPage();
                        },
                      );
                    },
                  ),
                  GestureDetector(
                    child: const Icon(
                      TechFreneticIcons.shareVideo,
                      size: 20,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: AppLocalizations.of(context)!.write_something,
                hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Theme.of(context).splashColor,
                ),
              ),
              onChanged: store.changePost,
            ),
            StreamBuilder(
              stream: store.postStream,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    return Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white, // background
                              onPrimary: Colors.black, // foreground
                              elevation: 0,
                              side: const BorderSide(
                                  width: 1, color: Colors.black),
                            ),
                            onPressed: () => addPost(snapshot.data!),
                            child: Text(
                              AppLocalizations.of(context)!.publish,
                              style: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .copyWith(fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                }

                return const SizedBox();
              },
            ),
          ]),
        ),
      ),
    );
  }

  Widget _feeds() {
    ArticlesProvider _articlesProvideer = ArticlesProvider();

    return FutureBuilder(
      future: _articlesProvideer.getWall(),
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
              _postbox(),
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

  void addPost(String post) async {
    debugPrint("Adding post with content: $post");

    ArticlesProvider articlesProvider = ArticlesProvider();
    bool created = await articlesProvider.addPost(post);
    if (created) {
      store.changePost("");
      setState(() {});
    } else {
      debugPrint("Unexpected error creating post");
    }
  }
}
