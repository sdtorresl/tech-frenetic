import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:techfrenetic/app/modules/articles/articles_store.dart';
import 'package:techfrenetic/app/modules/articles/widgets/categories_widget.dart';
import 'package:techfrenetic/app/modules/articles/widgets/content_widget.dart';
import 'package:techfrenetic/app/modules/articles/widgets/description_widget.dart';
import 'package:techfrenetic/app/modules/articles/widgets/image_selection_widget.dart';
import 'package:techfrenetic/app/modules/articles/widgets/tags_widget.dart';
import 'package:techfrenetic/app/modules/articles/widgets/title_widget.dart';
import 'package:techfrenetic/app/modules/articles/widgets/video_selection_widget.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';

class AddVideoArticlePage extends StatefulWidget {
  final void Function(int articleId)? onArticleAdded;
  const AddVideoArticlePage({Key? key, this.onArticleAdded}) : super(key: key);
  @override
  AddVideoArticlePageState createState() => AddVideoArticlePageState();
}

class AddVideoArticlePageState extends State<AddVideoArticlePage> {
  final ArticlesStore _articlesStore = Modular.get();

  @override
  void initState() {
    super.initState();
    _articlesStore.setupValidations();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding:
            const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 30),
        child: Column(children: [
          _header(context),
          Expanded(
            child: _articleForm(context),
          ),
        ]),
      ),
    );
  }

  Widget _header(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                HighlightContainer(
                    child: Text(
                  AppLocalizations.of(context)?.articles_create ?? '',
                  style: theme.textTheme.headline1!
                      .copyWith(color: theme.primaryColor, fontSize: 25),
                )),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  AppLocalizations.of(context)?.articles_video.toLowerCase() ??
                      '',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 25),
                )
              ],
            ),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        Divider(
          color: theme.primaryColor,
          thickness: 1,
        )
      ],
    );
  }

  Widget _articleForm(BuildContext context) {
    return Form(
      child: ListView(
        children: [
          const TitleWidget(),
          const ImageSelectionWidget(),
          const VideoSelectionWidget(),
          const DescriptionWidget(),
          const ContentWidget(),
          const SizedBox(height: 60),
          CategoriesWidget(),
          const SizedBox(height: 50),
          const TagsWidget(),
          const SizedBox(
            height: 20,
          ),
          _formButtons(context),
        ],
      ),
    );
  }

  _formButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Observer(builder: (context) {
            return ElevatedButton(
              onPressed: _articlesStore.isCompletedWithVideo &&
                      !_articlesStore.isLoading
                  ? _addArticle
                  : null,
              child: Text(AppLocalizations.of(context)!.publish),
            );
          }),
        ),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 4,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.white,
              side: BorderSide(width: 1, color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ],
    );
  }

  _addArticle() async {
    int? articleId = await _articlesStore.addArticle();

    if (articleId != null) {
      if (widget.onArticleAdded != null) {
        widget.onArticleAdded!(articleId);
      }
      Modular.to.popAndPushNamed("/community");
    } else {
      debugPrint('Article not posted');
    }
  }

  @override
  void dispose() {
    debugPrint("Dispose video");
    _articlesStore.dispose();
    super.dispose();
  }
}
