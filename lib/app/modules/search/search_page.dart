import 'package:techfrenetic/app/modules/search/widgets/group_item_widget.dart';

import '../../models/group_model.dart';
import '../../models/user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/modules/search/search_controller.dart';
import 'package:techfrenetic/app/providers/group_providers.dart';
import 'package:techfrenetic/app/providers/search_provider.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';
import 'package:techfrenetic/app/widgets/avatar_widget.dart';
import 'package:techfrenetic/app/widgets/save_content_widget.dart';
import 'package:techfrenetic/app/widgets/separator.dart';

enum SEARCH_CATEGORIES { content, users, groups, vendors }

class SearchPage extends StatefulWidget {
  final String title;
  const SearchPage({Key? key, this.title = 'SearchPage'}) : super(key: key);
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends ModularState<SearchPage, SearchController> {
  int selected = 0;
  String searchText = "";
  TextEditingController searchTextController = TextEditingController();
  SearchProvider searchResults = SearchProvider();
  GroupsProvider groupsProvider = GroupsProvider();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double separatorWidth = MediaQuery.of(context).size.width * 0.9;

    return Scaffold(
      appBar: TFAppBar(onPressed: () => Modular.to.pop()),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: _searchHeader(context),
          ),
          _searchTabs(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: _searchBox(),
          ),
          Separator(
            separatorWidth: separatorWidth,
            color: Colors.black,
            height: 2.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: _searchResults(),
          ),
        ],
      ),
    );
  }

  Widget _searchTabs() {
    List<Tab> tabs = List.generate(
      SEARCH_CATEGORIES.values.length,
      (index) {
        List<SEARCH_CATEGORIES> categories = SEARCH_CATEGORIES.values;
        String tabTitle;
        switch (categories[index]) {
          case SEARCH_CATEGORIES.content:
            tabTitle = AppLocalizations.of(context)!.search_tab_content;
            break;
          case SEARCH_CATEGORIES.groups:
            tabTitle = AppLocalizations.of(context)!.search_tab_groups;
            break;
          case SEARCH_CATEGORIES.users:
            tabTitle = AppLocalizations.of(context)!.search_tab_users;
            break;
          case SEARCH_CATEGORIES.vendors:
            tabTitle = AppLocalizations.of(context)!.search_tab_vendors;
            break;
        }
        return Tab(
          height: 35,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                    color: Theme.of(context).chipTheme.backgroundColor!,
                    width: 1)),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                tabTitle,
                maxLines: 1,
              ),
            ),
          ),
        );
      },
    );

    return DefaultTabController(
      length: tabs.length,
      // The Builder widget is used to have a different BuildContext to access
      // closest DefaultTabController.
      child: Builder(
        builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              setState(() {
                selected = tabController.index;
              });
            }
          });
          selected = tabController.index;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: TabBar(
              isScrollable: true,
              unselectedLabelColor: Theme.of(context).chipTheme.backgroundColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).chipTheme.backgroundColor),
              tabs: tabs,
            ),
          );
        },
      ),
    );
  }

  Widget _searchBox() {
    return StreamBuilder(
      stream: store.searchStream,
      builder: (context, snapshot) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 2, color: Theme.of(context).primaryColor),
              bottom:
                  BorderSide(width: 2, color: Theme.of(context).primaryColor),
              left: BorderSide(width: 2, color: Theme.of(context).primaryColor),
              right:
                  BorderSide(width: 2, color: Theme.of(context).primaryColor),
            ),
          ),
          child: TextFormField(
            controller: searchTextController,
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              prefixIcon:
                  Icon(Icons.search, color: Theme.of(context).primaryColor),
              suffixIcon: IconButton(
                icon: Icon(Icons.cancel,
                    color: Theme.of(context).unselectedWidgetColor),
                onPressed: () {
                  searchTextController.clear();
                  setState(() {
                    searchText = "";
                  });
                },
              ),
              hintText: AppLocalizations.of(context)!.search_text,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Theme.of(context).primaryColor),
              fillColor: Colors.white,
              filled: true,
            ),
            onChanged: (text) {
              setState(() {
                searchText = text;
              });
              store.changeSearch;
            },
            onFieldSubmitted: (text) {
              debugPrint("Submitted $text");
            },
          ),
        );
      },
    );
  }

  Widget _searchResults() {
    if (searchText.isEmpty) {
      return const SizedBox();
    }

    Widget results;

    List<SEARCH_CATEGORIES> categories = SEARCH_CATEGORIES.values;
    switch (categories[selected]) {
      case SEARCH_CATEGORIES.content:
        results = _articleResults();
        break;
      case SEARCH_CATEGORIES.groups:
        results = _groupResults();
        break;
      case SEARCH_CATEGORIES.users:
        results = _userResults();
        break;
      case SEARCH_CATEGORIES.vendors:
        results = _vendorResults();
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${AppLocalizations.of(context)!.search_results}: $searchText",
          style: Theme.of(context).textTheme.headline2,
          textAlign: TextAlign.left,
        ),
        results
      ],
    );
  }

  FutureBuilder<List<ArticlesModel>> _vendorResults() {
    return FutureBuilder(
      future: searchResults.getArticleByTitle(searchText),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          debugPrint(snapshot.data.toString());
          List<ArticlesModel> results = snapshot.data ?? [];
          List<Widget> resultsWidgets = [];
          debugPrint(results.toString());

          for (ArticlesModel results in results) {
            resultsWidgets.add(SaveContent(article: results));
          }

          return Column(
            children: [
              ...resultsWidgets,
              const SizedBox(height: 40),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _userResults() {
    return FutureBuilder(
      future: searchResults.searchUsers(searchText),
      builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
        if (snapshot.hasData) {
          debugPrint(snapshot.data.toString());
          List<UserModel> users = snapshot.data!;
          List<Widget> resultsWidgets = [];

          for (UserModel user in users) {
            resultsWidgets.add(_userItem(user, context));
          }

          return Column(
            children: [
              ...resultsWidgets,
              const SizedBox(height: 40),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _groupResults() {
    return FutureBuilder(
      future: groupsProvider.searchGroups(searchText),
      builder:
          (BuildContext context, AsyncSnapshot<List<GroupModel>> snapshot) {
        if (snapshot.hasData) {
          List<GroupModel> results = snapshot.data ?? [];

          debugPrint(results.toString());

          List<Widget> resultsWidgets =
              results.map((e) => GroupItemWidget(group: e)).toList();

          return Column(
            children: [
              ...resultsWidgets,
              const SizedBox(height: 40),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _articleResults() {
    return FutureBuilder(
      future: searchResults.getArticleByTitle(searchText),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          debugPrint(snapshot.data.toString());
          List<ArticlesModel> results = snapshot.data ?? [];
          List<Widget> resultsWidgets = [];
          debugPrint(results.toString());

          for (ArticlesModel results in results) {
            resultsWidgets.add(SaveContent(article: results));
          }

          return Column(
            children: [
              ...resultsWidgets,
              const SizedBox(height: 40),
            ],
          );
        } else {
          return const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _searchHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/img/icon.png',
            width: 50,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            AppLocalizations.of(context)!.search_looking,
            style: Theme.of(context).textTheme.headline2,
          )
        ],
      ),
    );
  }

  Widget _userItem(UserModel user, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              AvatarWidget(userId: user.uid.toString()),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    user.userName,
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
