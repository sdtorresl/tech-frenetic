import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/core/user_preferences.dart';
import 'package:techfrenetic/app/models/categories_model.dart';
import 'package:techfrenetic/app/providers/categories_provider.dart';
import 'package:techfrenetic/app/widgets/avatar_widget.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:techfrenetic/app/models/user_model.dart';

import '../certifications/certifications.dart';
import '../edit_name/edit_name_page.dart';
import '../edit_sumary/edit_sumary.dart';
import '../interests/interests_page.dart';

class MyProfilePage extends StatefulWidget {
  final UserModel user;
  final int avatarId;

  const MyProfilePage({
    Key? key,
    required this.user,
    required this.avatarId,
  }) : super(key: key);

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final _prefs = UserPreferences();
  final CategoriesProvider _categoriesProvicer = CategoriesProvider();
  bool editable = false;

  @override
  void initState() {
    editable = _prefs.userId == widget.user.uid.toString();
    super.initState();
  }

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
          editable
              ? Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const EditNamePage();
                        },
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const EditNamePage();
                    },
                  );
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
        _profileHeader(context, nameWidget),
        _profileBody(context),
        const SizedBox(height: 60),
      ],
    );
  }

  Widget _profileBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
          _dashboardHeader(context),
          const SizedBox(height: 20),
          _summaryBox(context),
          const SizedBox(height: 20),
          _aboutBody(context),
          const SizedBox(height: 20),
          _certificationsBody(context),
          const SizedBox(height: 20),
          _interestsBody(context),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _interestsBody(BuildContext context) {
    List<InterestModel>? interests = widget.user.interests;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(AppLocalizations.of(context)!.interest,
              style: Theme.of(context).textTheme.headline1),
          trailing: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return InterestsPage(user: widget.user);
                },
              );
            },
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).indicatorColor,
            ),
          ),
        ),
        FutureBuilder(
          future: _categoriesProvicer.getInterests(),
          builder: (BuildContext context,
              AsyncSnapshot<List<CategoriesModel>> snapshot) {
            if (snapshot.hasData) {
              List<CategoriesModel> interestsCategories = snapshot.data!;
              List<Widget> interestsInfo = [];

              for (InterestModel interest in interests) {
                String interestTitle = interestsCategories
                    .firstWhere(
                        (element) => element.id == interest.id.toString())
                    .category;
                interestsInfo.add(
                  ListTile(
                    title: Text(interestTitle),
                  ),
                );
              }

              return Column(
                children: [
                  ...interestsInfo,
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _certificationsBody(BuildContext context) {
    List certifications = widget.user.certifications;

    List<Widget> certificationsInfo = certifications
        .map(
          (e) => ListTile(
            title: Text(e.toString()),
          ),
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(AppLocalizations.of(context)!.certifications,
              style: Theme.of(context).textTheme.headline1),
          trailing: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CertificationsPage(user: widget.user);
                },
              );
            },
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).indicatorColor,
            ),
          ),
        ),
        ...certificationsInfo
      ],
    );
  }

  ListTile _aboutBody(BuildContext context) {
    return ListTile(
      title: Text(
        AppLocalizations.of(context)!.about,
        style: Theme.of(context).textTheme.headline1,
      ),
      trailing: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const EditSummaryPage();
            },
          );
        },
        icon: Icon(
          Icons.edit,
          color: Theme.of(context).indicatorColor,
        ),
      ),
    );
  }

  Padding _dashboardHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                HighlightContainer(
                  child: Text(
                    AppLocalizations.of(context)!.my,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(AppLocalizations.of(context)!.dashboard,
                    style: Theme.of(context).textTheme.headline1),
              ],
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
    );
  }

  Widget _profileHeader(BuildContext context, Widget nameWidget) {
    return Container(
      margin: const EdgeInsets.all(10.0),
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
              GestureDetector(
                onTap: () => Modular.to.pushNamed('/edit_avatar'),
                child: AvatarWidget(
                  userId: widget.avatarId.toString(),
                  radius: 40,
                ),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(widget.user.profession),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryBox(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _counterBox(
            AppLocalizations.of(context)!.articles,
            10,
            // () => Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const ProfilePage(selectedPage: 1),
            //),
          ),
          _counterBox(AppLocalizations.of(context)!.your_profile, 0
              //, () => debugPrint("Profile")
              ),
          _counterBox(
            AppLocalizations.of(context)!.post,
            100,
            //() => Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const ProfilePage(selectedPage: 1),
            //   ),
            // ),
          ),
        ],
      ),
    );
  }

  Widget _counterBox(
    String text,
    int counter,
    /*void Function() onPressed*/
  ) {
    return Flexible(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
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
        child: GestureDetector(
          onTap: null,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  counter.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 40),
                ),
              ),
              Container(
                constraints: const BoxConstraints(minHeight: 75),
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        text,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Theme.of(context).indicatorColor),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).indicatorColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
