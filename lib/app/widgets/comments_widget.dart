import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techfrenetic/app/models/comment_model.dart';
import 'package:techfrenetic/app/providers/comments_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentsWidget extends StatefulWidget {
  final String articleId;
  const CommentsWidget({Key? key, required this.articleId}) : super(key: key);

  @override
  State<CommentsWidget> createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget> {
  final CommnentsProvider _commentsProvider = CommnentsProvider();
  List<CommentModel> comments = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _commentsProvider.getComments(widget.articleId),
      builder:
          (BuildContext context, AsyncSnapshot<List<CommentModel>> snapshot) {
        if (snapshot.hasData) {
          comments = snapshot.data!;
          List<Widget> _commentsList = [];
          _commentsList =
              comments.map((e) => _commentBulble(context, e)).toList();
          return Column(
            children: [
              ..._commentsList,
              const SizedBox(
                height: 30,
              )
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _commentBulble(BuildContext context, CommentModel comment) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, top: 10),
          child: CircleAvatar(
            child: ClipOval(
              child: SvgPicture.asset(
                'assets/img/avatars/avatar-02.svg',
                semanticsLabel: 'Acme Logo',
              ),
            ),
            radius: 20,
            backgroundColor: Colors.grey[200],
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: Theme.of(context).backgroundColor,
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.user,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: SvgPicture.asset(
                        'assets/img/icons/dot.svg',
                        allowDrawingOutsideViewBox: true,
                        semanticsLabel: 'Dot',
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(timeago.format(comment.date, locale: 'en_short'),
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
                Text(comment.body),
              ],
            ),
          ),
        )
      ],
    );
  }
}
