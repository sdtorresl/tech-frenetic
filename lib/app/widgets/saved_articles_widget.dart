import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/models/saved_articles_model.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:techfrenetic/app/providers/saved_articles_provider.dart';
import 'package:techfrenetic/app/widgets/save_post_widget.dart';

class SavedArticles extends StatefulWidget {
  const SavedArticles({Key? key}) : super(key: key);

  @override
  _SavedArticlesState createState() => _SavedArticlesState();
}

class _SavedArticlesState extends State<SavedArticles> {
  @override
  Widget build(BuildContext context) {
    ArticlesProvider _articlesProvideer = ArticlesProvider();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
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
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: HighlightContainer(
                        child: Text(
                          AppLocalizations.of(context)!.saved_articles,
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    color: Theme.of(context).indicatorColor,
                                  ),
                        ),
                      ),
                    ),
                    Text('0 ' + AppLocalizations.of(context)!.articles)
                  ],
                ),
                FutureBuilder(
                  future: _articlesProvideer.getSavedArticles(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<ArticlesModel>> snapshot) {
                    if (snapshot.hasData) {
                      List<ArticlesModel> savedArticles = snapshot.data ?? [];
                      List<Widget> savedPostsWidgets = [];
                      for (ArticlesModel savedArticle in savedArticles) {
                        savedPostsWidgets
                            .add(SavedPost(savedPost: savedArticle));
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
          ),
        ],
      ),
    );
  }

//   Widget saveArticlePost(List<SavedArticlesModel> savedArticles) {
//     final SavedArticlesModel savedArticles;
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border(
//           top: BorderSide(
//             width: .5,
//             color: Colors.grey.withOpacity(.6),
//           ),
//         ),
//       ),
//       child: Column(
//         children: [Text('')],
//       ),
//     );
//   }
}
