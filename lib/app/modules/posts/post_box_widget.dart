import 'package:flutter/material.dart';
import 'package:techfrenetic/app/common/icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/modules/articles/add_article_page.dart';
import 'package:techfrenetic/app/modules/articles/add_video_article_page.dart';
import 'package:techfrenetic/app/modules/posts/post_box_controller.dart';
import 'package:techfrenetic/app/modules/posts/widgets/action_icon_widget.dart';
import 'package:techfrenetic/app/providers/articles_provider.dart';

class PostBoxWidget extends StatefulWidget {
  final void Function()? onPostLoaded;
  final void Function(int articleId)? onArticleLoaded;
  const PostBoxWidget({Key? key, this.onPostLoaded, this.onArticleLoaded})
      : super(key: key);

  @override
  State<PostBoxWidget> createState() => _PostBoxWidgetState();
}

class _PostBoxWidgetState extends State<PostBoxWidget> {
  final PostBoxController store = PostBoxController();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.addListener(() => store.changePost(_textController.text));
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFddedfe),
        border: Border(
          top: BorderSide(
            width: 1.90,
            color: Theme.of(context).primaryColor,
          ),
          left: BorderSide(
            width: 0.50,
            color: Colors.grey.withOpacity(.6),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              AppLocalizations.of(context)!.community_share_description,
              style: context.textTheme.bodyLarge?.copyWith(fontSize: 20),
            ),
          ),
          _actionIcons(context),
          _inputText(context),
          _publishButton(),
        ]),
      ),
    );
  }

  Widget _actionIcons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ActionIconWidget(
            icon: TechFreneticIcons.article,
            onPressed: _addArticle,
          ),
          ActionIconWidget(
            icon: TechFreneticIcons.shareVideo,
            onPressed: _addVideoArticle,
          ),
        ],
      ),
    );
  }

  Container _inputText(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: _textController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: AppLocalizations.of(context)!.write_something,
          hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
          /* prefixIcon: Icon(
                Icons.account_circle,
                color: Theme.of(context).splashColor,
              ), */
        ),
      ),
    );
  }

  StreamBuilder<String> _publishButton() {
    return StreamBuilder(
      stream: store.postStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return Container(
              margin: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // background
                      foregroundColor: Colors.black, // foreground
                      elevation: 0,
                      side: const BorderSide(width: 1, color: Colors.black),
                    ),
                    onPressed: () => _addPost(snapshot.data!),
                    child: Text(
                      AppLocalizations.of(context)!.publish,
                      style: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(fontSize: 14),
                    ),
                  )
                ],
              ),
            );
          }
        }

        return const SizedBox();
      },
    );
  }

  void _addPost(String post) async {
    ArticlesProvider articlesProvider = ArticlesProvider();
    bool created = await articlesProvider.addPost(post);
    if (created) {
      _textController.text = "";
      if (widget.onPostLoaded != null) {
        widget.onPostLoaded!();
      }
    } else {
      debugPrint("Unexpected error creating post");
    }
  }

  void _addArticle() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddArticlePage(
          onArticleAdded: widget.onArticleLoaded,
        );
      },
    );
  }

  void _addVideoArticle() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddVideoArticlePage(
          onArticleAdded: widget.onArticleLoaded,
        );
      },
    );
  }
}
