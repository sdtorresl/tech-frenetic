import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techfrenetic/app/core/user_preferences.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';
import 'package:techfrenetic/app/widgets/avatar_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class SaveActivityWidget extends StatefulWidget {
  final ArticlesModel article;

  const SaveActivityWidget({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  State<SaveActivityWidget> createState() => _SaveActivityWidgetState();
}

class _SaveActivityWidgetState extends State<SaveActivityWidget> {
  final prefs = UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Card(
        elevation: 2,
        shape: const ContinuousRectangleBorder(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _postAuthor(context),
            _postSummary(context),
            _postImage(context),
            _postTitle(context),
            _postTags(context),
            _postActionBar(context)
          ],
        ),
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
    UserProvider _userProvider = UserProvider();

    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
      child: Row(
        children: [
          FutureBuilder(
            future: _userProvider.getLoggedUser(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                debugPrint(snapshot.data.toString());
                return AvatarWidget(
                  userId: prefs.userId!,
                  radius: 20,
                );
              } else {
                return CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[200],
                );
              }
            },
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
