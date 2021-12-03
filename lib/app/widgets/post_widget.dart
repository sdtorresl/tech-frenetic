import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatefulWidget {
  final ArticlesModel article;
  const PostWidget({Key? key, required this.article}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _postAuthor(context),
          _postSummary(context),
          _postImage(context),
          _postTitle(context),
          _postTags(context),
          _postInteractions(context),
          _postActionBar(context)
        ],
      ),
    );
  }

  Widget _postSummary(BuildContext context) {
    Widget _summary = const SizedBox(height: 15);
    if (widget.article.summary!.isNotEmpty) {
      _summary = Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Text(widget.article.summary!),
      );
    }

    return _summary;
  }

  Widget _postTags(BuildContext context) {
    return widget.article.category!.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Text(
              widget.article.category!.toUpperCase(),
              style:
                  Theme.of(context).textTheme.headline4!.copyWith(fontSize: 12),
            ),
          )
        : const SizedBox();
  }

  Padding _postAuthor(BuildContext context) {
    final created = widget.article.date!;

    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.withOpacity(0.2),
            child: ClipOval(
              child: SvgPicture.asset(
                'assets/img/avatars/avatar-02.svg',
                semanticsLabel: 'Acme Logo',
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.article.displayName,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 15),
              ),
              Row(
                children: [
                  Text(widget.article.role!,
                      style: Theme.of(context).textTheme.bodyText1),
                  SizedBox(
                    child: SvgPicture.asset(
                      'assets/img/icons/dot.svg',
                      allowDrawingOutsideViewBox: true,
                      semanticsLabel: 'Dot',
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(timeago.format(created, locale: 'en_short'),
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _postImage(BuildContext context) {
    Widget _image = const SizedBox();
    if (widget.article.image != null) {
      _image = CachedNetworkImage(
        placeholder: (context, value) => const LinearProgressIndicator(),
        errorWidget: (context, value, e) => const Icon(Icons.error),
        imageUrl: widget.article.image!,
      );
    }

    return _image;
  }

  Widget _postTitle(BuildContext context) {
    if (widget.article.title.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Text(
          widget.article.title,
          style: Theme.of(context).textTheme.headline4!,
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _postInteractions(BuildContext context) {
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
          Text(widget.article.comments! +
              ' ' +
              AppLocalizations.of(context)!.comment),
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
          Text(widget.article.comments! +
              ' ' +
              AppLocalizations.of(context)!.comments),
        ],
      );
    }

    return Column(
      children: [
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
              SvgPicture.asset(
                'assets/img/icons/dot.svg',
                allowDrawingOutsideViewBox: true,
                semanticsLabel: 'Dot',
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(widget.article.views! +
                  ' ' +
                  AppLocalizations.of(context)!.views),
            ],
          ),
        ),
      ],
    );
  }

  Widget _postActionBar(context) {
    return Column(
      children: [
        const Divider(
          height: 0,
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _actionButton(
                context: context,
                iconAsset: 'assets/img/icons/light_bulb.svg',
                text: 'Cool',
                onPressed: () => {debugPrint("Like!")},
              ),
              _actionButton(
                context: context,
                iconAsset: 'assets/img/icons/coment.svg',
                text: AppLocalizations.of(context)!.comment2,
                onPressed: () {
                  Modular.to.pushNamed("/community/article",
                      arguments: widget.article);
                },
              ),
              _actionButton(
                context: context,
                iconAsset: 'assets/img/icons/share.svg',
                text: AppLocalizations.of(context)!.share,
                onPressed: () => {debugPrint("Share article")},
              ),
            ],
          ),
        ),
      ],
    );
  }

  TextButton _actionButton(
      {required BuildContext context,
      required String iconAsset,
      required String text,
      required void Function() onPressed}) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          SvgPicture.asset(
            iconAsset,
            allowDrawingOutsideViewBox: true,
            semanticsLabel: 'Text Box',
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
