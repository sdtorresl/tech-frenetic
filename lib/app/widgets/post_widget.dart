import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techfrenetic/app/providers/articles_provider.dart';
import 'package:techfrenetic/app/models/articles_model.dart';

class PostWidget extends StatefulWidget {
  final ArticlesModel article;
  const PostWidget({Key? key, required this.article}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    Widget _summary = const SizedBox(height: 15);
    if (widget.article.summary.isNotEmpty) {
      _summary = Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Text(widget.article.summary),
      );
    }

    Widget _comments = const SizedBox();
    if (widget.article.comments != '0' && widget.article.comments == '1') {
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
          Text(widget.article.comments + ' comment'),
        ],
      );
    }
    if (widget.article.comments != '0' && widget.article.comments != '1') {
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
          Text(widget.article.comments + ' comments'),
        ],
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.00,
              color: Theme.of(context).unselectedWidgetColor,
            ),
            left: BorderSide(
              width: 0.50,
              color: Colors.grey.withOpacity(.6),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).unselectedWidgetColor,
              spreadRadius: -5,
              blurRadius: 5,
              offset: const Offset(1.9, 1.7),
            )
          ]),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
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
                        widget.article.user,
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 15),
                      ),
                      Row(
                        children: [
                          Text("Profession 1",
                              style: Theme.of(context).textTheme.bodyText1),
                          SizedBox(
                            child: SvgPicture.asset(
                              'assets/img/icons/dot.svg',
                              allowDrawingOutsideViewBox: true,
                              semanticsLabel: 'Dot',
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text('13 days ago',
                              style: Theme.of(context).textTheme.bodyText1),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            _summary,
            CachedNetworkImage(
              placeholder: (context, value) => const LinearProgressIndicator(),
              errorWidget: (context, value, e) => const Icon(Icons.error),
              imageUrl: widget.article.image,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Text(
                widget.article.category,
                style: Theme.of(context).textTheme.headline4!,
              ),
            ),
            const Divider(
              height: 0,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: [
                  _comments,
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    child: SvgPicture.asset(
                      'assets/img/icons/dot.svg',
                      allowDrawingOutsideViewBox: true,
                      semanticsLabel: 'Dot',
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const Text('4 views'),
                ],
              ),
            ),
            const Divider(
              height: 0,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    child: SvgPicture.asset(
                      'assets/img/icons/light_bulb.svg',
                      allowDrawingOutsideViewBox: true,
                      semanticsLabel: 'Ligth Bulb',
                    ),
                  ),
                  const Text('Cool'),
                  const SizedBox(width: 20),
                  SizedBox(
                    child: SvgPicture.asset(
                      'assets/img/icons/coment.svg',
                      allowDrawingOutsideViewBox: true,
                      semanticsLabel: 'Text Box',
                    ),
                  ),
                  const Text('Comment'),
                  const SizedBox(width: 20),
                  SizedBox(
                    child: SvgPicture.asset(
                      'assets/img/icons/share.svg',
                      allowDrawingOutsideViewBox: true,
                      semanticsLabel: 'Share Icon',
                    ),
                  ),
                  const Text('Share'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
