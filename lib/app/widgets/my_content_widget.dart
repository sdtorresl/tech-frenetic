import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/core/user_preferences.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:techfrenetic/app/providers/articles_provider.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/widgets/save_content_widget.dart';

class MyContent extends StatefulWidget {
  const MyContent({Key? key}) : super(key: key);

  @override
  _MyContentState createState() => _MyContentState();
}

class _MyContentState extends State<MyContent> {
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
                Text('0 ' + AppLocalizations.of(context)!.articles)
              ],
            ),
          ),
          FutureBuilder(
            future: _articlesProvideer.getWall(),
            builder: (BuildContext context,
                AsyncSnapshot<List<ArticlesModel>> snapshot) {
              if (snapshot.hasData) {
                List<ArticlesModel> contents = snapshot.data ?? [];
                List<Widget> savedPostsWidgets = [];
                for (ArticlesModel content in contents) {
                  if (content.type == 'Article' &&
                      _prefs.userName == content.user) {
                    debugPrint(content.toString());
                    savedPostsWidgets.add(
                      SaveContent(savedPost: content),
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
