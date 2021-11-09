import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:techfrenetic/app/models/saved_articles_model.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SavedPost extends StatefulWidget {
  final SavedArticlesModel savedPost;
  const SavedPost({Key? key, required this.savedPost}) : super(key: key);

  @override
  _SaveState createState() => _SaveState();
}

class _SaveState extends State<SavedPost> {
  @override
  Widget build(BuildContext context) {
    final createdTimeAgo =
        widget.savedPost.date.subtract(const Duration(minutes: 15));
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
                        widget.savedPost.category,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 16,
                            color: Theme.of(context).indicatorColor),
                      ),
                    ),
                    Text(timeago.format(createdTimeAgo),
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
                        imageUrl: widget.savedPost.thumbnail,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 30),
            _actionBar(context),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _actionBar(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(.6),
              radius: 10.0,
              child: ClipOval(
                child: SvgPicture.asset(
                  'assets/img/icons/light_bulb.svg',
                  semanticsLabel: 'Light Bulb',
                ),
              ),
            ),
            const SizedBox(width: 5),
            Text(
              widget.savedPost.views,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SvgPicture.asset(
              'assets/img/icons/dot.svg',
              semanticsLabel: 'Dot',
              color: Theme.of(context).primaryColor,
            ),
            Text(
              widget.savedPost.comments + ' Comments',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SvgPicture.asset(
              'assets/img/icons/dot.svg',
              semanticsLabel: 'Dot',
              color: Theme.of(context).primaryColor,
            ),
            Text(
              '4 Share',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.star,
              color: Theme.of(context).primaryColor,
            ),
            Text(
              widget.savedPost.votes.isNotEmpty
                  ? widget.savedPost.votes
                  : '0' + '/5',
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        )
      ],
    );
  }
}
