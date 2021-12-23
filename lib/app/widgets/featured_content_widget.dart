import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:techfrenetic/app/models/articles_model.dart';

class FeaturedArticleWidget extends StatefulWidget {
  final ArticlesModel article;

  const FeaturedArticleWidget({Key? key, required this.article})
      : super(key: key);

  @override
  State<FeaturedArticleWidget> createState() => _FeaturedArticleWidgetState();
}

class _FeaturedArticleWidgetState extends State<FeaturedArticleWidget> {
  @override
  Widget build(BuildContext context) {
    final created = widget.article.date!;

    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Wrap(
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  widget.article.category!.toUpperCase(),
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Theme.of(context).primaryColor, fontSize: 18),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: SvgPicture.asset(
                    'assets/img/icons/dot.svg',
                    allowDrawingOutsideViewBox: true,
                    semanticsLabel: 'Dot',
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  timeago.format(
                    created,
                  ),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Modular.to
                .pushNamed('/community/article', arguments: widget.article),
            child: CachedNetworkImage(
              placeholder: (context, value) => const LinearProgressIndicator(),
              errorWidget: (context, value, e) => const Icon(Icons.error),
              imageUrl: widget.article.thumbnail!,
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              widget.article.title,
              style:
                  Theme.of(context).textTheme.headline1!.copyWith(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.article.displayName,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 15),
                ),
                const IconButton(
                  icon: Icon(Icons.shield_outlined),
                  onPressed: null,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
