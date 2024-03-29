import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/core/user_preferences.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:techfrenetic/app/providers/articles_provider.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/widgets/save_content_widget.dart';

class MyContentPage extends StatefulWidget {
  const MyContentPage({Key? key}) : super(key: key);

  @override
  _MyContentPageState createState() => _MyContentPageState();
}

class _MyContentPageState extends State<MyContentPage> {
  @override
  Widget build(BuildContext context) {
    ArticlesProvider _articlesProvideer = ArticlesProvider();
    final _prefs = UserPreferences();
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  width: 1.90,
                  color: Theme.of(context).primaryColor,
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
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: HighlightContainer(
                    child: Text(
                      AppLocalizations.of(context)!.my_content,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Theme.of(context).indicatorColor,
                          ),
                    ),
                  ),
                ),
                FutureBuilder(
                  future: _articlesProvideer
                      .getArticlesByUser(_prefs.userName ?? ' '),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    int number = 0;
                    if (snapshot.hasData) {
                      List<ArticlesModel> contents = snapshot.data ?? [];
                      number = contents.length;
                    }
                    return Text(
                        '$number ' + AppLocalizations.of(context)!.articles);
                  },
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: _articlesProvideer.getArticlesByUser(_prefs.userName ?? ''),
            builder: (BuildContext context,
                AsyncSnapshot<List<ArticlesModel>> snapshot) {
              if (snapshot.hasData) {
                List<ArticlesModel> contents = snapshot.data ?? [];
                List<Widget> savedPostsWidgets = [];

                for (ArticlesModel content in contents) {
                  savedPostsWidgets.add(
                    SaveContent(article: content),
                  );
                }

                return Column(
                  children: [
                    const SizedBox(height: 10),
                    ...savedPostsWidgets,
                    const SizedBox(height: 60),
                  ],
                );
              } else {
                return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()));
              }
            },
          ),
        ],
      ),
    );
  }
}
