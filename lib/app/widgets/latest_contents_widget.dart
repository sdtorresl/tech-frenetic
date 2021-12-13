import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:techfrenetic/app/models/articles_model.dart';

class LatestArticleWidget extends StatefulWidget {
  final ArticlesModel article;

  const LatestArticleWidget({Key? key, required this.article})
      : super(key: key);

  @override
  State<LatestArticleWidget> createState() => _LatestArticleWidgetState();
}

class _LatestArticleWidgetState extends State<LatestArticleWidget> {
  @override
  Widget build(BuildContext context) {
    final created = widget.article.date!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          CachedNetworkImage(
              placeholder: (context, value) => const LinearProgressIndicator(),
              errorWidget: (context, value, e) => const Icon(Icons.error),
              imageUrl: widget.article.thumbnail!),
          Row(
            children: [
              Text(
                widget.article.category!.toUpperCase(),
                style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 18),
              ),
              SvgPicture.asset(
                'assets/img/icons/dot.svg',
                allowDrawingOutsideViewBox: true,
                semanticsLabel: 'Dot',
                color: Theme.of(context).primaryColor,
              ),
              Text(
                  timeago.format(
                    created,
                  ),
                  style: Theme.of(context).textTheme.bodyText1),
            ],
          ),
          Text(
            widget.article.title,
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 20),
          ),
          Row(
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
          const SizedBox(height: 20),
          Container(
            color: Theme.of(context).unselectedWidgetColor,
            height: .5,
            width: 400,
          ),
        ],
      ),
    );
  }
}
