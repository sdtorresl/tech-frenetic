import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/community/community_store.dart';
import 'package:techfrenetic/app/modules/community/widgets/feeds_widget.dart';
import 'package:techfrenetic/app/modules/community/widgets/video_advertisement_widget.dart';
import 'package:techfrenetic/app/modules/meetups/meetups_page.dart';
import 'package:techfrenetic/app/modules/groups/groups_page.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  CommunityPageState createState() => CommunityPageState();
}

class CommunityPageState extends State<CommunityPage> {
  final CommunityStore _communityStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  @override
  void initState() {
    _communityStore.fetchVideo();
    super.initState();
  }

  Widget _buildBody() {
    return Observer(builder: (context) {
      switch (_communityStore.state) {
        case StoreState.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case StoreState.initial:
          return _buildTabs();
        default:
          if (_communityStore.advertisement != null) {
            return Stack(
              children: [
                Positioned(child: _buildTabs()),
                VideoAdvertisementWidget(video: _communityStore.advertisement!),
              ],
            );
          }

          return _buildTabs();
      }
    });
  }

  DefaultTabController _buildTabs() {
    final List<Tab> tabs = <Tab>[
      Tab(
        height: 35,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
                color: Theme.of(context).chipTheme.backgroundColor!, width: 1),
          ),
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
              width: 1,
            ),
          ),
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
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/img/bg_community.png'),
              fit: BoxFit.fitHeight,
            ),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
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
                  const FeedsWidget(),
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

  Widget _meetups() {
    return const MetupsPage();
  }

  Widget _groups() {
    return const GroupsPage();
  }
}
