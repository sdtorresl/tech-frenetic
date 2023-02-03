import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techfrenetic/app/common/icons.dart';
import 'package:techfrenetic/app/core/extensions.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/models/notification_model.dart';
import 'package:techfrenetic/app/models/video_model.dart';
import 'package:techfrenetic/app/providers/comments_provider.dart';
import 'package:techfrenetic/app/providers/like_provider.dart';
import 'package:techfrenetic/app/providers/notifications_provider.dart';
import 'package:techfrenetic/app/providers/video_provider.dart';
import 'package:techfrenetic/app/widgets/avatar_widget.dart';
import 'package:techfrenetic/app/widgets/video_player_widget.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:share_plus/share_plus.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:intl/intl.dart';

import 'comments_widget.dart';

class PostWidget extends StatefulWidget {
  final ArticlesModel article;
  const PostWidget({Key? key, required this.article}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final VideoProvider _videoProvider = VideoProvider();
  final CommentsProvider _commentsProvider = CommentsProvider();
  final NotificationsProvider _notificationsProvider = NotificationsProvider();

  String likeAsset = '';
  bool enabledLike = true;
  int currentLikes = 0;
  final TextEditingController _commentTextController = TextEditingController();

  bool _postCommentsVisible = false;

  @override
  void initState() {
    super.initState();
    enabledLike = true;
    currentLikes = int.tryParse(widget.article.likes ?? '0') ?? 0;
    likeAsset = 'assets/img/icons/light_bulb.svg';
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
          widget.article.isVideo ? _postVideo(context) : _postImage(context),
          _postTitle(context),
          _postTags(context),
          _postInteractions(context),
          _postActionBar(context),
          _postCommentsVisible ? _postComments() : const SizedBox.shrink(),
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
    Widget _imageWidget = const SizedBox();
    if (widget.article.image != null) {
      _imageWidget = GestureDetector(
        child: CachedNetworkImage(
          placeholder: (context, value) => const LinearProgressIndicator(),
          errorWidget: (context, value, e) => const Icon(Icons.error),
          imageUrl: widget.article.image!,
        ),
        onTap: () => Modular.to
            .pushNamed("/community/article", arguments: widget.article),
      );
    }

    return _imageWidget;
  }

  Widget _postTitle(BuildContext context) {
    if (widget.article.title.isNotEmpty) {
      Widget text = Text(
        widget.article.title.parseHtmlString().trim(),
        style: Theme.of(context).textTheme.headline4!,
      );

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        //child: Html(data: widget.article.title),
        child: widget.article.type == ArticleType.article
            ? TextButton(
                child: text,
                onPressed: () => Modular.to
                    .pushNamed("/community/article", arguments: widget.article),
              )
            : text,
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _postInteractions(BuildContext context) {
    Widget _likes = const SizedBox();

    Widget _commentText = Text(
        "${widget.article.comments} ${widget.article.comments == 1 ? AppLocalizations.of(context)!.comment : AppLocalizations.of(context)!.comments}");
    Widget _comments = widget.article.comments >= 0
        ? Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: SizedBox(
                  child: SvgPicture.asset(
                    'assets/img/icons/dot.svg',
                    allowDrawingOutsideViewBox: true,
                    semanticsLabel: 'Dot',
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              widget.article.type == ArticleType.article
                  ? GestureDetector(
                      onTap: () {
                        Modular.to.pushNamed("/community/article",
                            arguments: widget.article);
                      },
                      child: _commentText)
                  : _commentText,
            ],
          )
        : const SizedBox.shrink();

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

    if (widget.article.type == ArticleType.article) {
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
                onPressed: () => setState(() {
                  _postCommentsVisible = !_postCommentsVisible;
                }),
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
    super.dispose();
  }

  Widget _postComments() {
    return Column(
      children: [CommentsWidget(articleId: widget.article.id), _commentsForm()],
    );
  }

  Widget _commentsForm() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 10),
      child: SafeArea(
        child: Row(
          children: [
            Flexible(
              child: TextField(
                keyboardType: TextInputType.multiline,
                controller: _commentTextController,
                onSubmitted: (value) => submitComment(),
              ),
            ),
            IconButton(
              onPressed: submitComment,
              icon: const Icon(TechFreneticIcons.comment),
            )
          ],
        ),
      ),
    );
  }

  void submitComment() {
    _commentsProvider
        .addComment(widget.article.id, _commentTextController.text)
        .then((commentId) {
      if (commentId != null) {
        debugPrint("Comment ID is $commentId");
        _commentTextController.clear();
        setState(() {});
        _notificationsProvider.postNotification(
          contentId: widget.article.id,
          type: NotificationType.commentNotification,
          targetId: commentId,
        );
      }
    });
  }
}
