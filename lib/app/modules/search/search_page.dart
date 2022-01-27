import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:techfrenetic/app/modules/search/search_controller.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';

enum SEARCH_CATEGORIES { content, users, groups, vendors }

class SearchPage extends StatefulWidget {
  final String title;
  const SearchPage({Key? key, this.title = 'SearchPage'}) : super(key: key);
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends ModularState<SearchPage, SearchController> {
  String selected = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TFAppBar(onPressed: () => Modular.to.pop()),
      body: Column(
        children: [
          _searchHeader(context),
          _searchTabs(),
          _searchBox(),
          _searchResults(),
        ],
      ),
    );
  }

  DefaultTabController _searchTabs() {
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
                    color: Theme.of(context).chipTheme.backgroundColor,
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
                selected = tabController.index.toString();
              });
            }
          });
          selected = tabController.index.toString();

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
    return SizedBox();
  }

  Widget _searchResults() {
    return Text("Selectd box: $selected");
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
}
