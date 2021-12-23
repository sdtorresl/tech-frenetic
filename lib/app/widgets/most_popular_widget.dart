import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:techfrenetic/app/models/articles_model.dart';

class MostPopularWidget extends StatefulWidget {
  final ArticlesModel article;
  final int potition;

  const MostPopularWidget(
      {Key? key, required this.article, required this.potition})
      : super(key: key);

  @override
  _MostPopularWidgetState createState() => _MostPopularWidgetState();
}

class _MostPopularWidgetState extends State<MostPopularWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              Text(
                widget.potition.toString(),
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.article.category!.toUpperCase(),
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Theme.of(context).primaryColor, fontSize: 15),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 150,
                      child: Text(
                        widget.article.title,
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text('By ',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(fontSize: 15)),
                        Text(widget.article.displayName,
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(fontSize: 15)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
