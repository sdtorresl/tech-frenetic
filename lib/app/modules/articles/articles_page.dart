import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:techfrenetic/app/common/icons.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/modules/articles/articles_controller.dart';
import 'package:techfrenetic/app/modules/articles/articles_image_page.dart';
import 'package:techfrenetic/app/providers/articles_provider.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';
import 'package:techfrenetic/app/widgets/avatar_widget.dart';
import 'package:techfrenetic/app/widgets/comments_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticlesPage extends StatefulWidget {
  final ArticlesModel article;
  const ArticlesPage({Key? key, required this.article}) : super(key: key);
  @override
  ArticlesPageState createState() => ArticlesPageState();
}

class ArticlesPageState extends ModularState<ArticlesPage, ArticlesController> {
  ArticlesModel article = ArticlesModel.empty();
  final ArticlesProvider _articlesProvider = ArticlesProvider();
  TextEditingController commentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _articleAppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              future: _articlesProvider.getArticle(widget.article.id),
              builder: (BuildContext context,
                  AsyncSnapshot<ArticlesModel> snapshot) {
                if (snapshot.hasData) {
                  article = snapshot.data!;

                  return ListView(
                    children: [
                      _articleTitle(),
                      _articleHeader(),
                      _articleImage(),
                      _articleSummary(),
                      _articleInteractions(),
                      CommentsWidget(articleId: widget.article.id),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          _commentsForm()
        ],
      ),
    );
  }

  Widget _articleImage() {
    if (article.image != null) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => ArticleImagePage(
                url: article.image!,
              ),
            ),
          );
        },
        child: SizedBox(
          height: 250,
          child: Hero(
            tag: 'articleImage',
            child: CachedNetworkImage(
              placeholder: (context, value) => const LinearProgressIndicator(),
              errorWidget: (context, value, e) => const Icon(Icons.error),
              imageUrl: article.image!,
            ),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _avatar() {
    Widget avatar;
    if (article.uid != null) {
      avatar = AvatarWidget(
        userId: article.uid!,
      );
    } else {
      avatar = const SizedBox();
    }
    return avatar;
  }

  Widget _dot() {
    Widget dot = const SizedBox();
    if (article.id != '') {
      dot = SvgPicture.asset(
        'assets/img/icons/dot.svg',
        allowDrawingOutsideViewBox: true,
        semanticsLabel: 'Dot',
        color: Theme.of(context).primaryColor,
      );
    }

    return dot;
  }

  Widget _articleHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
      child: Row(
        children: [
          _avatar(),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.user!,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 15),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: SizedBox(
                      child: _dot(),
                    ),
                  ),
                  Text(
                    article.date != null
                        ? timeago.format(article.date!, locale: 'en_short')
                        : "",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  PreferredSizeWidget _articleAppBar() {
    ThemeData theme = Theme.of(context);
    return TFAppBar(
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        widget.article.category!.toUpperCase(),
        style: theme.textTheme.headline5!.copyWith(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).primaryColorDark,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () => debugPrint("Like!"),
          icon: const Icon(TechFreneticIcons.lightBulb),
        ),
        IconButton(
          onPressed: () => debugPrint("Share!"),
          icon: const Icon(TechFreneticIcons.share),
        )
      ],
    );
  }

  Widget _articleTitle() {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        article.title,
        style: theme.textTheme.headline2,
      ),
    );
  }

  Widget _articleSummary() {
    Widget _summary = const SizedBox(height: 15);
    if (article.summary!.isNotEmpty) {
      _summary = Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Html(
          data: article.body,
        ),
      );
    }

    return _summary;
  }

  Widget _articleInteractions() {
    Widget _comments = const SizedBox();
    if (article.comments != '0' && article.comments == '1') {
      _comments = Row(
        children: [
          SizedBox(
            child: SvgPicture.asset(
              'assets/img/icons/dot.svg',
              allowDrawingOutsideViewBox: true,
              semanticsLabel: 'Dot',
              color: Theme.of(context).primaryColor,
            ),
          ),
          Text(article.comments! + ' ' + AppLocalizations.of(context)!.comment),
        ],
      );
    }
    return _comments;
  }

  Widget _commentsForm() {
    return StreamBuilder(
      stream: store.commentStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  controller: commentTextController,
                  onChanged: store.changeComment,
                ),
              ),
              IconButton(
                onPressed: submitComment,
                icon: const Icon(TechFreneticIcons.coment),
              )
            ],
          ),
        );
      },
    );
  }

  void submitComment() {
    debugPrint("Comment is: ${store.comment}");
    store.changeComment("");
    commentTextController.text = store.comment;
    setState(() {});
  }
}
