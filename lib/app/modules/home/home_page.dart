import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/common/icons.dart';
import 'package:techfrenetic/app/core/user_preferences.dart';
import 'package:techfrenetic/app/modules/articles/add_article_page.dart';
import 'package:techfrenetic/app/modules/home/home_store.dart';
import 'package:techfrenetic/app/modules/profile/profile_store.dart';
import 'package:techfrenetic/app/modules/videos/video_source.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';
import 'package:techfrenetic/app/widgets/avatar_widget.dart';
import 'package:techfrenetic/app/widgets/expandable_fab.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:techfrenetic/app/widgets/drawer_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore _homeStore = Modular.get();
  final ProfileStore _profileStore = Modular.get();
  final UserProvider _userProvider = Modular.get();

  final List<String> _pages = [
    '/community',
    '/skills',
    '/vendors',
    '/profile/profile'
  ];
  final prefs = UserPreferences();

  @override
  void initState() {
    _homeStore.selectedPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return FutureBuilder(
      future: _userProvider.getLoggedUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Row(
              children: [
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    _homeStore.selectedPage = 0;
                    Modular.to.navigate(_pages[_homeStore.selectedPage]);
                  },
                  child:
                      Image.asset('assets/img/main-logo.png', fit: BoxFit.fill),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            actions: [
              _searchMenu(),
              _userMenu(),
              _openDrawer(_scaffoldKey),
            ],
          ),
          endDrawer: CustomDrawer(),
          body: const RouterOutlet(),
          floatingActionButton: _floatingActionButton(),
          bottomNavigationBar: _bottomNavigationBar(),
        );
      },
    );
  }

  Widget _openDrawer(GlobalKey<ScaffoldState> _scaffoldKey) {
    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {
        _scaffoldKey.currentState!.openEndDrawer();
      },
    );
  }

  Widget _searchMenu() {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {
        Modular.to.pushNamed('/search');
      },
    );
  }

  Widget _userMenu() {
    return PopupMenuButton(
      child: Container(
        width: 50,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Observer(
          name: 'avatarObserver',
          builder: (context) {
            debugPrint("Logged user: ${_homeStore.loggedUser.toString()}");
            if (_homeStore.loggedUser != null) {
              return AvatarWidget(
                userId: _homeStore.loggedUser!.uid.toString(),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
      offset: const Offset(0, 60),
      color: Colors.white,
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: Text(
            AppLocalizations.of(context)!.notification_button,
            style: const TextStyle(color: Colors.black),
          ),
          onTap: () => Modular.to.pushNamed('/notifications'),
        ),
        PopupMenuItem<int>(
          onTap: () {
            _profileStore.index = 0;
            _homeStore.selectedPage = 3;
            Modular.to.navigate('/profile/profile');
          },
          value: 1,
          child: Text(
            AppLocalizations.of(context)!.profile,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Text(
            AppLocalizations.of(context)!.logout_button,
            style: const TextStyle(color: Colors.black),
          ),
          onTap: () async {
            UserProvider userProvider = UserProvider();
            await userProvider.logout();
            Modular.to.pushNamedAndRemoveUntil(
                "/login", ModalRoute.withName("/login"));
          },
        ),
      ],
      onSelected: (item) => {
        debugPrint(
          item.toString(),
        ),
      },
    );
  }

  Widget _floatingActionButton() {
    final GlobalKey<ExpandableFabState> _key = GlobalKey();
    List<Widget> actions = [
      ActionButton(
        onPressed: () {
          if (_key.currentState != null) {
            _key.currentState!.toggle();
          }
          showVideoSources(context);
        },
        icon: const Icon(TechFreneticIcons.shareVideo),
      ),
      ActionButton(
        onPressed: () {
          if (_key.currentState != null) {
            _key.currentState!.toggle();
          }
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddArticlePage();
            },
          );
        },
        icon: const Icon(TechFreneticIcons.article),
      ),
      ActionButton(
        onPressed: () {
          if (_key.currentState != null) {
            _key.currentState!.toggle();
          }
          Modular.to.pushNamed('/chat');
        },
        icon: const Icon(Icons.chat_rounded),
      ),
    ];

    return ExpandableFab(
      key: _key,
      distance: 110.0,
      children: actions,
    );
  }

  Widget _bottomNavigationBar() {
    return Observer(
      builder: (context) => TitledBottomNavigationBar(
        reverse: true,
        currentIndex: _homeStore.selectedPage,
        onTap: (index) {
          _homeStore.selectedPage = index;
          Modular.to.navigate(_pages[_homeStore.selectedPage]);
        },
        curve: Curves.easeInBack,
        items: [
          TitledNavigationBarItem(
              title: Text(AppLocalizations.of(context)!.community),
              icon: const Icon(Icons.people_alt_outlined)),
          TitledNavigationBarItem(
              title: Text(AppLocalizations.of(context)!.skills),
              icon: const Icon(Icons.home)),
          TitledNavigationBarItem(
              title: Text(AppLocalizations.of(context)!.vendors),
              icon: const Icon(Icons.card_travel)),
          TitledNavigationBarItem(
              title: Text(AppLocalizations.of(context)!.profile),
              icon: const Icon(Icons.person_outline)),
        ],
      ),
    );
  }
}
