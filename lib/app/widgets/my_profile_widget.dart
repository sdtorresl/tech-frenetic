import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:techfrenetic/app/models/user_model.dart';

class MyProfile extends StatefulWidget {
  final UserModel user;
  const MyProfile({Key? key, required this.user}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    List<String> name = widget.user.name.split(' ');
    Widget nameWidget = const SizedBox();
    if (name.length < 2) {
      nameWidget = Stack(
        children: [
          Center(
            child: HighlightContainer(
              child: Text(
                widget.user.name,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Theme.of(context).indicatorColor,
                    ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                debugPrint('Im working');
              },
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).indicatorColor,
              ),
            ),
          ),
        ],
      );
    } else {
      for (String words in name.getRange(1, name.length)) {
        String nameStr = words;

        nameWidget = Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HighlightContainer(
                  child: Text(
                    name[0],
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Theme.of(context).indicatorColor,
                        ),
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(nameStr, style: Theme.of(context).textTheme.headline1),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  debugPrint('Im working');
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).indicatorColor,
                ),
              ),
            ),
          ],
        );
      }
    }

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
                child: Column(
                  children: [
                    CircleAvatar(
                      child: ClipOval(
                        child: SvgPicture.asset(
                          widget.user.fieldUserAvatar.isNotEmpty
                              ? 'assets/img/avatars/' +
                                  widget.user.fieldUserAvatar +
                                  '.svg'
                              : 'assets/img/avatars/avatar-01.svg',
                          semanticsLabel: 'Acme Logo',
                        ),
                      ),
                      radius: 40,
                      backgroundColor: Colors.grey[200],
                    ),
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: nameWidget),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(widget.user.userProfession),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: AppLocalizations.of(context)!.my,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            Theme.of(context).primaryColor,
                                        decorationThickness: 2.0,
                                      )),
                              TextSpan(
                                  text: AppLocalizations.of(context)!.dashboar,
                                  style: Theme.of(context).textTheme.headline1),
                            ],
                          ),
                        ),
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
                ),
                const SizedBox(height: 30),
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '0',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(fontSize: 40),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.articles,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .indicatorColor),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () {
                                        debugPrint('Im working');
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Theme.of(context).indicatorColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                left: BorderSide(
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
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  '0',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(fontSize: 40),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .who_viewed,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .indicatorColor),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .your_profile,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .indicatorColor),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        onPressed: () {
                                          debugPrint('Im working');
                                        },
                                        icon: Icon(
                                          Icons.arrow_forward_ios,
                                          color:
                                              Theme.of(context).indicatorColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '0',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(fontSize: 40),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.post,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .indicatorColor),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () {
                                        debugPrint('Im working');
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Theme.of(context).indicatorColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: Text(
                    AppLocalizations.of(context)!.about,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      debugPrint('Im working');
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    AppLocalizations.of(context)!.view_more,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Theme.of(context).indicatorColor,
                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(context).indicatorColor,
                        decorationThickness: 2),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.certifications,
                      style: Theme.of(context).textTheme.headline1),
                  trailing: IconButton(
                    onPressed: () {
                      debugPrint('Im working');
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      left: BorderSide(
                        width: 0.50,
                        color: Colors.grey.withOpacity(.6),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.interest,
                      style: Theme.of(context).textTheme.headline1),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
