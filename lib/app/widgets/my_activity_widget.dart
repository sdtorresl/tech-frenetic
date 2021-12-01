import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/preferences/user_preferences.dart';
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
  @override
  Widget build(BuildContext context) {
    ArticlesProvider _articlesProvideer = ArticlesProvider();
    final _prefs = UserPreferences();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Container(
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
            child: Card(
              elevation: 0,
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
          ),
          FutureBuilder(
            future: _articlesProvideer.getRelatedArticles(),
            builder: (BuildContext context,
                AsyncSnapshot<List<ArticlesModel>> snapshot) {
              if (snapshot.hasData) {
                List<ArticlesModel> articles = snapshot.data ?? [];
                List<Widget> savedPostsWidgets = [];
                for (ArticlesModel article in articles) {
                  if (article.type == 'Post' &&
                      _prefs.userName == article.user) {
                    savedPostsWidgets.add(
                      SaveActivityWidget(article: article),
                    );
                  }
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(
                          width: .5,
                          color: Colors.grey.withOpacity(.6),
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        ...savedPostsWidgets,
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
