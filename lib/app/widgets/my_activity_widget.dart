import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/core/user_preferences.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:techfrenetic/app/providers/articles_provider.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/widgets/save_activity_widget.dart';

class MyActivity extends StatefulWidget {
  const MyActivity({Key? key}) : super(key: key);

  @override
  _MyActivityState createState() => _MyActivityState();
}

class _MyActivityState extends State<MyActivity> {
  late Future<List<ArticlesModel>> _articles;

  @override
  void initState() {
    ArticlesProvider _articlesProvideer = ArticlesProvider();
    _articles = _articlesProvideer.getWall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _prefs = UserPreferences();
    return ListView(
      children: [
        Container(
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
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: HighlightContainer(
                child: Text(
                  AppLocalizations.of(context)!.my_activity,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).indicatorColor,
                      ),
                ),
              ),
            ),
          ),
        ),
        FutureBuilder(
          future: _articles,
          builder: (BuildContext context,
              AsyncSnapshot<List<ArticlesModel>> snapshot) {
            if (snapshot.hasData) {
              List<ArticlesModel> articles = snapshot.data ?? [];
              List<Widget> savedPostsWidgets = [];
              for (ArticlesModel article in articles) {
                if (article.type == 'Post' && _prefs.userName == article.user) {
                  savedPostsWidgets.add(
                    SaveActivityWidget(article: article),
                  );
                }
              }

              return Column(
                children: [
                  ...savedPostsWidgets,
                  const SizedBox(height: 60),
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
        ),
      ],
    );
  }
}
