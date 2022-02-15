import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class SaveContent extends StatefulWidget {
  final ArticlesModel article;
  const SaveContent({Key? key, required this.article}) : super(key: key);

  @override
  _SaveState createState() => _SaveState();
}

class _SaveState extends State<SaveContent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Modular.to.pushNamed("/community/article", arguments: widget.article),
      child: Card(
        shape: const ContinuousRectangleBorder(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.article.category!,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 16,
                          color: Theme.of(context).indicatorColor),
                    ),
                    Text(
                      timeago.format(widget.article.date!),
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 12),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 150,
                      child: Text(
                        widget.article.title,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.article.displayName,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: SizedBox(
                height: 200,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  placeholder: (context, value) =>
                      const LinearProgressIndicator(),
                  errorWidget: (context, value, e) => const Icon(Icons.error),
                  imageUrl: widget.article.image!,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
