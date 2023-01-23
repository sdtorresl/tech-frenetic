import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/models/video_model.dart';
import 'package:techfrenetic/app/providers/like_provider.dart';
import 'package:techfrenetic/app/providers/video_provider.dart';
import 'package:techfrenetic/app/widgets/avatar_widget.dart';
import 'package:techfrenetic/app/widgets/video_player_widget.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:share_plus/share_plus.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class PostWidget extends StatefulWidget {
  final ArticlesModel article;
  const PostWidget({Key? key, required this.article}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final VideoProvider _videoProvider = VideoProvider();

  String likeAsset = '';
  bool enabledLike = true;
  int currentLikes = 0;
  VideoPlayerController? _controller1;

  @override
  void initState() {
    super.initState();
    enabledLike = true;
    currentLikes = int.tryParse(widget.article.likes ?? '0') ?? 0;
    likeAsset = 'assets/img/icons/light_bulb.svg';

    if (widget.article.isVideo) {
      _controller1 = VideoPlayerController.network(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
        ..initialize().then((_) {
          if (mounted) {
            setState(() {});
          }
        });
    }
  }

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
          GestureDetector(
              child: _postAuthor(context),
              onTap: () => Modular.to
                  .pushNamed("/users_profiles", arguments: widget.article.uid)),
          _postSummary(context),
          widget.article.isVideo
              ? _postVideo(context)
              : GestureDetector(
                  child: _postImage(context),
                  onTap: () => Modular.to.pushNamed("/community/article",
                      arguments: widget.article),
                ),
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

  Widget _postAuthor(BuildContext context) {
    final created = widget.article.date!;

    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
      child: Row(
        children: [
          AvatarWidget(
            userId: widget.article.uid!,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
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
                    Expanded(
                      flex: 4,
                      child: Text(
                        widget.article.role!,
                        style: Theme.of(context).textTheme.bodyText1,
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                      child: SvgPicture.asset(
                        'assets/img/icons/dot.svg',
                        allowDrawingOutsideViewBox: true,
                        semanticsLabel: 'Dot',
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Flexible(
                      child: Text(timeago.format(created, locale: 'en_short'),
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _postVideo(BuildContext context) {
    Widget videoWidget = const SizedBox();
    if (widget.article.isVideo && widget.article.videoId != null) {
      videoWidget = FutureBuilder(
        future: _videoProvider.getVideo(widget.article.videoId!),
        builder: (BuildContext context, AsyncSnapshot<VideoModel?> snapshot) {
          if (snapshot.hasData) {
            VideoModel? video = snapshot.data;
            if (video != null && video.playback != null) {
              return VideoPlayerWidget(url: video.playback!.hls);
            }
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }

    return videoWidget;
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
    Widget _likes = const SizedBox();

    if (widget.article.comments != '0' && widget.article.comments == '1') {
      _comments = Row(
        children: [
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
          Text(widget.article.comments! +
              ' ' +
              AppLocalizations.of(context)!.comment),
        ],
      );
    }

    if (widget.article.comments != '0' && widget.article.comments != '1') {
      _comments = Row(
        children: [
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
          Text(widget.article.comments! +
              ' ' +
              AppLocalizations.of(context)!.comments),
        ],
      );
    }

    if (widget.article.likes != '0') {
      _likes = Row(
        children: [
          SvgPicture.asset(
            'assets/img/icons/light_bulb.svg',
            semanticsLabel: 'light_bulb',
          ),
          const SizedBox(
            width: 10,
          ),
          Text(currentLikes.toString()),
          const SizedBox(
            width: 10,
          ),
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
              _likes,
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

  Widget _likeButton(context) {
    LikeProvider likeProvider = LikeProvider();
    Widget likeButton;

    if (enabledLike == true) {
      likeButton = _actionButton(
        context: context,
        iconAsset: likeAsset,
        text: 'Cool',
        onPressed: () {
          likeProvider.like(widget.article.id);
          if (mounted) {
            setState(() {
              enabledLike = false;
              currentLikes++;
              likeAsset = 'assets/img/icons/bright_bulb.svg';
            });
          }
        },
      );
    } else {
      likeButton = _actionButton(
        context: context,
        iconAsset: likeAsset,
        text: 'Cool',
        onPressed: () {
          likeProvider.dislike();
          setState(
            () {
              enabledLike = true;
              currentLikes--;
              likeAsset = 'assets/img/icons/light_bulb.svg';
            },
          );
        },
      );
    }
    return likeButton;
  }

  Widget _shareButton(context) {
    Widget shareButton;
    String articleLink;
    String articlePath = widget.article.url!;

    if (widget.article.type == 'Article') {
      final String baseUrl = GlobalConfiguration().getValue("api_url");
      final String locale =
          Intl.getCurrentLocale().startsWith("es") ? "es" : "en";
      List<String> splitUrl = articlePath.split('/');
      String urlEnd = splitUrl.last;
      articleLink = baseUrl + '/$locale/' + urlEnd;
      shareButton = _actionButton(
        context: context,
        iconAsset: 'assets/img/icons/share.svg',
        text: AppLocalizations.of(context)!.share,
        onPressed: () => {
          Share.share(articleLink,
              subject: AppLocalizations.of(context)!.share_message + '\n')
        },
      );
    } else {
      shareButton = const SizedBox();
    }
    return shareButton;
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
              _likeButton(context),
              _actionButton(
                context: context,
                iconAsset: 'assets/img/icons/coment.svg',
                text: AppLocalizations.of(context)!.comment2,
                onPressed: () {
                  Modular.to.pushNamed("/community/article",
                      arguments: widget.article);
                },
              ),
              _shareButton(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _actionButton(
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

  @override
  void dispose() {
    _controller1?.dispose();
    super.dispose();
  }
}
