import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techfrenetic/app/common/icons.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/modules/articles/articles_controller.dart';
import 'package:techfrenetic/app/providers/articles_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticlesPage extends StatefulWidget {
  final ArticlesModel article;
  const ArticlesPage({Key? key, required this.article}) : super(key: key);
  @override
  ArticlesPageState createState() => ArticlesPageState();
}

class ArticlesPageState extends ModularState<ArticlesPage, ArticlesController> {
  ArticlesModel article = ArticlesModel.empty();

  @override
  Widget build(BuildContext context) {
    ArticlesProvider _articlesProvider = ArticlesProvider();
    _articlesProvider.getArticle("/articles/flutter-2-here").then((value) {
      setState(() {
        article = value;
      });
    });

    return Scaffold(
      appBar: _articleAppBar(context),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: [
                _articleTitle(context),
                _articleHeader(context),
                _articleImage(context),
                _articleSummary(context),
                _articleComments(context),
              ],
            ),
          ),
          const _CommentForm()
        ],
      ),
    );
  }

  Widget _articleImage(BuildContext context) {
    if (article.image != null) {
      return CachedNetworkImage(
        placeholder: (context, value) => const LinearProgressIndicator(),
        errorWidget: (context, value, e) => const Icon(Icons.error),
        imageUrl: article.image!,
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _articleHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
      child: Row(
        children: [
          CircleAvatar(
            child: ClipOval(
              child: SvgPicture.asset(
                'assets/img/avatars/avatar-02.svg',
                semanticsLabel: 'Acme Logo',
              ),
            ),
            radius: 20,
            backgroundColor: Colors.grey[200],
          ),
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
                  Text(
                    "Profession 1",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: SizedBox(
                      child: SvgPicture.asset(
                        'assets/img/icons/dot.svg',
                        allowDrawingOutsideViewBox: true,
                        semanticsLabel: 'Dot',
                        color: Theme.of(context).primaryColor,
                      ),
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

  AppBar _articleAppBar(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        article.category!.toUpperCase(),
        style: theme.textTheme.headline5!.copyWith(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).primaryColorDark,
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

  Widget _articleTitle(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        article.title,
        style: theme.textTheme.headline2,
      ),
    );
  }

  Widget _articleSummary(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Widget _summary = const SizedBox(height: 15);
    if (article.summary!.isNotEmpty) {
      _summary = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Text(article.summary!, style: theme.textTheme.headline2),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Text(article.body!),
          ),
        ],
      );
    }

    return _summary;
  }

  Widget _articleComments(BuildContext context) {
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
          Text(article.comments! + ' comment'),
        ],
      );
    }
    return _comments;
  }
}

class _CommentForm extends StatelessWidget {
  const _CommentForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          const Flexible(child: TextField()),
          IconButton(
            onPressed: () => debugPrint("Comment!"),
            icon: const Icon(TechFreneticIcons.coment),
          )
        ],
      ),
    );
  }
}
