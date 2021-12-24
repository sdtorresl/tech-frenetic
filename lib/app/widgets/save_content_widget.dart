import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/models/articles_model.dart';

import 'package:timeago/timeago.dart' as timeago;

class SaveContent extends StatefulWidget {
  final ArticlesModel savedPost;
  const SaveContent({Key? key, required this.savedPost}) : super(key: key);

  @override
  _SaveState createState() => _SaveState();
}

class _SaveState extends State<SaveContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () => Modular.to
            .pushNamed("/community/article", arguments: widget.savedPost),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                width: .8,
                color: Colors.grey.withOpacity(.8),
              ),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 150,
                        child: Text(
                          widget.savedPost.category!,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontSize: 16,
                                  color: Theme.of(context).indicatorColor),
                        ),
                      ),
                      Text(timeago.format(widget.savedPost.date!),
                          style: Theme.of(context).textTheme.bodyText1),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 150,
                        child: Text(
                          widget.savedPost.title,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(widget.savedPost.displayName,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontSize: 15)),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 150,
                        height: 100,
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
                          placeholder: (context, value) =>
                              const LinearProgressIndicator(),
                          errorWidget: (context, value, e) =>
                              const Icon(Icons.error),
                          imageUrl: widget.savedPost.image!,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 30),
              //_actionBar(context),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
