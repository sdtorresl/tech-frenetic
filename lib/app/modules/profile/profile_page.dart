import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  final String title;
  const ProfilePage({Key? key, this.title = 'ProfilePage'}) : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final List<GButton> tabs = <GButton>[
      GButton(
        icon: Icons.person,
        text: AppLocalizations.of(context)!.my_profile,
      ),
      GButton(
        icon: Icons.article_rounded,
        text: AppLocalizations.of(context)!.my_content,
      ),
      GButton(
        icon: Icons.local_activity,
        text: AppLocalizations.of(context)!.my_activity,
      ),
      GButton(
        icon: Icons.save,
        text: AppLocalizations.of(context)!.saved_articles,
      ),
      GButton(
        icon: Icons.manage_accounts,
        text: AppLocalizations.of(context)!.my_account,
      ),
    ];

    return DefaultTabController(
      length: tabs.length,
      // The Builder widget is used to have a different BuildContext to access
      // closest DefaultTabController.
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: GNav(
                tabBorderRadius: 50,
                tabActiveBorder: Border.all(
                  color: Theme.of(context).chipTheme.backgroundColor,
                  width: 1,
                ),
                tabBorder: Border.all(color: Colors.transparent, width: 0),
                duration: const Duration(milliseconds: 200),
                gap: 8,
                color: Theme.of(context).chipTheme.labelStyle.color,
                activeColor: Colors.white,
                iconSize: 24,
                tabBackgroundColor: Theme.of(context).chipTheme.backgroundColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                tabs: tabs,
                onTabChange: (index) => tabController.animateTo(index),
              ),
            ),
            Expanded(
              child: TabBarView(children: [
                _myProfile(context),
                _myContent(context),
                _myActivity(context),
                _savedArticles(context),
                _myAccount(context)
              ]),
            ),
          ],
        );
      }),
    );
  }

  Widget _myProfile(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
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
                  spreadRadius: -5,
                  blurRadius: 5,
                  offset: const Offset(1.9, 1.7),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Theme.of(context).cardColor,
                elevation: 0,
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Sergio',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              color: Theme.of(context).indicatorColor,
                              backgroundColor:
                                  Theme.of(context).backgroundColor,
                            )),
                  ),
                  subtitle: Row(
                    children: const [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text('0 Followers'),
                      ),
                      Text('0 Following')
                    ],
                  ),
                  leading: CircleAvatar(
                    child: ClipOval(
                      child: SvgPicture.asset(
                        'assets/img/avatars/avatar-01.svg',
                        semanticsLabel: 'Acme Logo',
                      ),
                    ),
                    radius: 40,
                    backgroundColor: Colors.grey[200],
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                left: BorderSide(
                  width: 0.50,
                  color: Colors.grey.withOpacity(.6),
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).unselectedWidgetColor,
                  spreadRadius: -5,
                  blurRadius: 5,
                  offset: const Offset(1.9, 1.7),
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('My dashboard',
                          style: Theme.of(context).textTheme.headline1),
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Only for you',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        left: BorderSide(
                          width: 0.50,
                          color: Colors.grey.withOpacity(.6),
                        ),
                        top: BorderSide(
                          width: 0.50,
                          color: Colors.grey.withOpacity(.6),
                        ),
                        bottom: BorderSide(
                          width: 0.50,
                          color: Colors.grey.withOpacity(.6),
                        ),
                        right: BorderSide(
                          width: 0.50,
                          color: Colors.grey.withOpacity(.6),
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Text(
                              '0',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(fontSize: 40),
                            ),
                            ListTile(
                              title: Text(
                                'Articles',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                width: 0.50,
                                color: Colors.grey.withOpacity(.6),
                              ),
                              bottom: BorderSide(
                                width: 0.50,
                                color: Colors.grey.withOpacity(.6),
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '0',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(fontSize: 40),
                              ),
                              ListTile(
                                title: Text(
                                  'Articles',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              '0',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(fontSize: 40),
                            ),
                            ListTile(
                              title: Text(
                                'Articles',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'about',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  trailing: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'view_more',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
                ListTile(
                  title: Text('certifications',
                      style: Theme.of(context).textTheme.headline1),
                  trailing: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                ListTile(
                  title: Text('interest',
                      style: Theme.of(context).textTheme.headline1),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _myContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                spreadRadius: -5,
                blurRadius: 5,
                offset: const Offset(1.9, 1.7),
              )
            ],
          ),
          child: Row(
            children: [
              Text(AppLocalizations.of(context)!.my_content),
              const Text('0 Articles')
            ],
          )),
    );
  }

  Widget _myActivity(BuildContext context) {
    return Text(AppLocalizations.of(context)!.my_activity);
  }

  Widget _savedArticles(BuildContext context) {
    return Text(AppLocalizations.of(context)!.saved_articles);
  }

  Widget _myAccount(BuildContext context) {
    return Text(AppLocalizations.of(context)!.my_account);
  }
}
