import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/common/icons.dart';
import 'package:techfrenetic/app/core/extensions.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/models/video_model.dart';
import 'package:techfrenetic/app/modules/community/widgets/post_action_button_widget.dart';
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

import '../../../models/enums/notification_type_enum.dart';
import '../../../widgets/comments_widget.dart';

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
  int _comments = 0;
  final TextEditingController _commentTextController = TextEditingController();

  bool _postCommentsVisible = false;

  @override
  void initState() {
    super.initState();
    enabledLike = true;
    currentLikes = int.tryParse(widget.article.likes ?? '0') ?? 0;
    _comments = widget.article.comments;
    likeAsset = 'assets/img/icons/light_bulb.svg';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: context.theme.primaryColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: _postAuthor(context),
            onTap: () => Modular.to
                .pushNamed("/users_profiles", arguments: widget.article.uid),
          ),
          _postSummary(context),
          widget.article.isVideo ? _postVideo(context) : _postImage(context),
          _postTitle(context),
          //_postTags(context),
          _postActionBar(context),
          _postInteractions(context),
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
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: context.theme.primaryColor),
              borderRadius: BorderRadius.circular(50),
            ),
            child: AvatarWidget(
              userId: widget.article.uid!,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.article.displayName,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 15,
                        color: context.theme.primaryColorDark,
                      ),
                ),
                Text(
                  timeago.format(created, locale: 'en_short'),
                  style: context.textTheme.bodySmall?.copyWith(fontSize: 12),
                ),
                /*  Row(
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
                ) */
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
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: VideoPlayerWidget(url: video.playback!.hls),
              );
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
      _imageWidget = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: GestureDetector(
          child: CachedNetworkImage(
            placeholder: (context, value) => const LinearProgressIndicator(),
            errorWidget: (context, value, e) => const Icon(Icons.error),
            imageUrl: widget.article.image!,
            height: 250,
            fit: BoxFit.cover,
          ),
          onTap: () => Modular.to
              .pushNamed("/community/article", arguments: widget.article),
        ),
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
        padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
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
    Widget _commentText = Text(
        "${_comments.toString()} ${_comments == 1 ? AppLocalizations.of(context)!.comment : AppLocalizations.of(context)!.comments}");
    Widget _commentsWidget = _comments >= 0
        ? Row(
            children: [
              const Icon(
                Icons.chat_bubble_outline_outlined,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              widget.article.type == ArticleType.article
                  ? GestureDetector(
                      onTap: () {
                        Modular.to.pushNamed("/community/article",
                            arguments: widget.article);
                      },
                      child: _commentText,
                    )
                  : _commentText,
            ],
          )
        : const SizedBox.shrink();

    Widget _likes = widget.article.likes != '0'
        ? Row(
            children: [
              const Icon(
                Icons.emoji_emotions_outlined,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(currentLikes.toString()),
            ],
          )
        : const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          _likes,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text("|"),
          ),
          _commentsWidget,
        ],
      ),
    );
  }

  void _like() {
    LikeProvider likeProvider = LikeProvider();

    if (enabledLike == true) {
      likeProvider.like(widget.article.id);
      if (mounted) {
        setState(() {
          enabledLike = false;
          currentLikes++;
        });
      }
    } else {
      likeProvider.dislike();
      setState(
        () {
          enabledLike = true;
          currentLikes--;
        },
      );
    }
  }

  _share() {
    final String baseUrl = GlobalConfiguration().getValue("api_url");
    final String locale =
        Intl.getCurrentLocale().startsWith("es") ? "es" : "en";
    String articleLink = "$baseUrl/$locale/${widget.article.id}";
    Share.share(articleLink,
        subject: AppLocalizations.of(context)!.share_message + '\n');
  }

  Widget _postActionBar(BuildContext context) {
    var children = [
      PostActionButtonWidget(
        iconAsset: !enabledLike
            ? 'assets/img/icons/bright_bulb.svg'
            : 'assets/img/icons/light_bulb.svg',
        text: context.appLocalizations?.community_like ?? '',
        onPressed: _like,
      ),
      PostActionButtonWidget(
        iconAsset: 'assets/img/icons/coment.svg',
        text: context.appLocalizations?.comment2 ?? '',
        onPressed: _toggleComments,
      ),
    ];

    if (widget.article.type == ArticleType.article) {
      children.add(PostActionButtonWidget(
        iconAsset: 'assets/img/icons/share.svg',
        text: context.appLocalizations?.share ?? '',
        onPressed: _share,
      ));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
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
        setState(() {
          _comments++;
        });
        _notificationsProvider.postNotification(
          type: NotificationType.comment,
          targetId: commentId,
        );
      }
    });
  }

  _toggleComments() {
    setState(() {
      _postCommentsVisible = !_postCommentsVisible;
    });
  }
}
