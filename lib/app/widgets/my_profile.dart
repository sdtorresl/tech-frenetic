import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
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
                    child: Text(
                      'Sergio',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Theme.of(context).indicatorColor,
                            backgroundColor: Theme.of(context).backgroundColor,
                          ),
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                            '0 ' + AppLocalizations.of(context)!.followers),
                      ),
                      Text('0 ' + AppLocalizations.of(context)!.following)
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppLocalizations.of(context)!.my_dashboard,
                          style: Theme.of(context).textTheme.headline1),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context)!.only_for_you,
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
                                AppLocalizations.of(context)!.articles,
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
                                  AppLocalizations.of(context)!
                                      .who_viewed_your_profile,
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
                                AppLocalizations.of(context)!.post,
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
                    AppLocalizations.of(context)!.about,
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
                    AppLocalizations.of(context)!.view_more,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.certifications,
                      style: Theme.of(context).textTheme.headline1),
                  trailing: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.interest,
                      style: Theme.of(context).textTheme.headline1),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
