import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/modules/posts/post_box_widget.dart';
import 'package:techfrenetic/app/providers/articles_provider.dart';
import 'package:techfrenetic/app/widgets/post_widget.dart';

import 'stories_view_widget.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({Key? key}) : super(key: key);

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  final ArticlesProvider _articlesProvider = ArticlesProvider();
  int _page = 0;
  List _posts = [];
  bool _isFirstLoading = true;
  bool _isMoreLoading = false;
  bool _hasNextPage = true;
  late ScrollController _scrollController;

  void _firsLoad() async {
    List<ArticlesModel> articles = await _articlesProvider.getWall();
    setState(() {
      _isFirstLoading = false;
      _posts = articles;
      _page = 0;
    });
  }

  void _loadMore() async {
    bool isEndOfScroll = _scrollController.position.extentAfter < 10;

    if (_hasNextPage == true &&
        _isFirstLoading == false &&
        _isMoreLoading == false &&
        isEndOfScroll) {
      setState(() {
        _isMoreLoading = true;
      });

      _page = _page + 1;

      debugPrint("Loading more articles. Page $_page");
      List<ArticlesModel> articles =
          await _articlesProvider.getWall(page: _page);

      if (articles.isEmpty) {
        _hasNextPage = false;
      }

      setState(() {
        _posts.addAll(articles);
        _isMoreLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_loadMore);
    _firsLoad();
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirstLoading == false) {
      List<Widget> postsWidgets =
          _posts.map((a) => PostWidget(article: a)).toList();

      return ListView(
        shrinkWrap: true,
        controller: _scrollController,
        children: [
          PostBoxWidget(
            onPostLoaded: () {
              setState(() {
                _posts = [];
                _isFirstLoading = true;
                _isMoreLoading = false;
                _hasNextPage = true;
              });
              _firsLoad();
            },
            onArticleLoaded: (id) {
              debugPrint("El id de artículo es: $id");
            },
          ),
          const StoriesViewWidget(),
          ...postsWidgets,
          _isMoreLoading
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Center(child: CircularProgressIndicator()),
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 60),
        ],
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
