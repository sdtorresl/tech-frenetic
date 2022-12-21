import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/core/user_preferences.dart';
import 'package:techfrenetic/app/models/categories_model.dart';
import 'package:techfrenetic/app/modules/community/widgets/stories_view_widget.dart';
import 'package:techfrenetic/app/modules/home/home_store.dart';
import 'package:techfrenetic/app/modules/profile/my_profile/certifications/certifications_page.dart';
import 'package:techfrenetic/app/modules/profile/my_profile/edit_name/edit_name_page.dart';
import 'package:techfrenetic/app/modules/profile/my_profile/edit_summary/edit_summary_page.dart';
import 'package:techfrenetic/app/modules/profile/my_profile/interests/interests_page.dart';
import 'package:techfrenetic/app/modules/profile/profile_store.dart';
import 'package:techfrenetic/app/providers/articles_provider.dart';
import 'package:techfrenetic/app/providers/categories_provider.dart';
import 'package:techfrenetic/app/providers/followers_provider.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';
import 'package:techfrenetic/app/widgets/avatar_widget.dart';
import 'package:techfrenetic/app/widgets/follow_button_widget.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:techfrenetic/app/models/user_model.dart';

class MyProfilePage extends StatefulWidget {
  final String? userId;

  const MyProfilePage({
    Key? key,
    this.userId,
  }) : super(key: key);

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final HomeStore _homeStore = Modular.get();
  final ProfileStore _profileStore = Modular.get();
  final FollowersProvider _followersProvider = Modular.get();
  final ArticlesProvider _articlesProvider = ArticlesProvider();
  final CategoriesProvider _categoriesProvicer = CategoriesProvider();
  final UserPreferences _prefs = UserPreferences();
  final UserProvider _userProvider = UserProvider();

  bool editable = true;
  bool isFollowingUser = true;
  int articlesCount = 0;
  int postsCount = 0;
  int viewedCount = 0;
  int followers = 0;
  late int userId;
  late UserModel user;

  @override
  void initState() {
    super.initState();
    userId = widget.userId != null
        ? int.parse(widget.userId!)
        : int.parse(_prefs.userId!);
    editable =
        _prefs.userId != null ? userId == int.parse(_prefs.userId!) : false;
    isFollowingUser = false;
    //loadCounts();
  }

  void loadCounts() async {
    _articlesProvider.getArticlesByUser(user.userName).then((articles) {
      setState(() {
        articlesCount = articles.length;
      });
    });

    _articlesProvider.getPostsByUser(user.userName).then((posts) {
      setState(() {
        postsCount = posts.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (_homeStore.loggedUser?.uid.toString() == _prefs.userId &&
          _homeStore.loggedUser != null) {
        user = _homeStore.loggedUser!;
      }
      return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: FutureBuilder(
          future: _userProvider.getUser(userId.toString()),
          builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                user = snapshot.data!;
                return _profileView();
              }
            }

            return const Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                width: 35.0,
                height: 35.0,
              ),
            );
          },
        ),
      );
    });
  }

  Widget _profileView() {
    return ListView(
      children: [
        _profileHeader(context),
        !editable
            ? StoriesViewWidget(
                userId: userId,
              )
            : const SizedBox.shrink(),
        _profileBody(context),
        const SizedBox(height: 60),
      ],
    );
  }

  Widget _nameWidget() {
    List<String> name = user.name.split(' ');

    Widget nameWidget = const SizedBox();

    if (name.length < 2) {
      nameWidget = Stack(
        children: [
          Center(
            child: HighlightContainer(
              child: Text(
                user.name,
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
          alignment: AlignmentDirectional.center,
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
            editable
                ? Align(
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
                  )
                : const SizedBox.shrink(),
          ],
        );
      }
    }
    return nameWidget;
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
          editable ? _dashboardHeader(context) : const SizedBox.shrink(),
          editable ? const SizedBox(height: 20) : const SizedBox.shrink(),
          editable ? _dashboard(context) : const SizedBox.shrink(),
          editable ? const SizedBox(height: 20) : const SizedBox.shrink(),
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
    List<InterestModel>? interests = user.interests;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(AppLocalizations.of(context)!.interest,
              style: Theme.of(context).textTheme.headline1),
          trailing: editable
              ? IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return InterestsPage(user: user);
                      },
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).indicatorColor,
                  ),
                )
              : const SizedBox.shrink(),
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
    List certifications = user.certifications;

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
          trailing: editable
              ? IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CertificationsPage(user: user);
                      },
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).indicatorColor,
                  ),
                )
              : const SizedBox.shrink(),
        ),
        ...certificationsInfo
      ],
    );
  }

  Widget _aboutBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            AppLocalizations.of(context)!.about,
            style: Theme.of(context).textTheme.headline1,
          ),
          trailing: editable
              ? IconButton(
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
                )
              : const SizedBox.shrink(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(user.biography),
        )
      ],
    );
  }

  Widget _dashboardHeader(BuildContext context) {
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

  Widget _profileHeader(BuildContext context) {
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
                onTap: editable
                    ? () => Modular.to.pushNamed('/edit_avatar')
                    : null,
                child: AvatarWidget(
                  userId: user.uid.toString(),
                  radius: 40,
                ),
              ),
              Container(
                child: _nameWidget(),
                margin: const EdgeInsets.only(top: 15),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  user.profession,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                ),
              ),
              _followers()
            ],
          ),
        ),
      ),
    );
  }

  Widget _followers() {
    return FutureBuilder(
      future: Future.wait([
        _followersProvider.getFollowing(userId),
        _followersProvider.getFollowers(userId),
      ]),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<UserModel> followingList = snapshot.data[0];
          List<UserModel> followersList = snapshot.data[1];
          followers = followersList.length;
          return Column(
            children: [
              TextButton(
                  onPressed: () => Modular.to.pushNamed('/following',
                          arguments: {
                            'following': followingList,
                            'followers': followersList
                          }),
                  child: Text(
                      "$followers ${AppLocalizations.of(context)!.profile_followers} - ${followingList.length} ${AppLocalizations.of(context)!.profile_following}")),
              editable
                  ? const SizedBox.shrink()
                  : FollowButtonWidget(
                      targetUserId: userId,
                      onFollow: onFollow,
                    )
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _dashboard(BuildContext context) {
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
            articlesCount,
            () {
              _profileStore.index = 1;
              Modular.to.navigate('/profile/content');
            },
          ),
          _counterBox(
            AppLocalizations.of(context)!.your_profile,
            viewedCount,
            () {
              _profileStore.index = 1;
              Modular.to.navigate('/profile/content');
            },
          ),
          _counterBox(
            AppLocalizations.of(context)!.post,
            postsCount,
            () {
              _profileStore.index = 2;
              Modular.to.navigate('/profile/activity');
            },
          ),
        ],
      ),
    );
  }

  Widget _counterBox(String text, int counter, void Function() onPressed) {
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
          onTap: onPressed,
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

  void onFollow() {
    setState(() {
      followers += 1;
    });
  }
}
