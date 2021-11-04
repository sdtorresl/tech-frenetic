import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';

class SavedArticles extends StatefulWidget {
  const SavedArticles({Key? key}) : super(key: key);

  @override
  _SavedArticlesState createState() => _SavedArticlesState();
}

class _SavedArticlesState extends State<SavedArticles> {
  @override
  Widget build(BuildContext context) {
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
                      AppLocalizations.of(context)!.saved_articles,
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
        ],
      ),
    );
  }
}
