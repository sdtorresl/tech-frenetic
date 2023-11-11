import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/models/advertisement_model.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/modules/community/widgets/advertisement_widget.dart';
import 'package:techfrenetic/app/modules/posts/post_box_widget.dart';
import 'package:techfrenetic/app/providers/advertisement_provider.dart';
import 'package:techfrenetic/app/providers/articles_provider.dart';
import 'package:techfrenetic/app/modules/community/widgets/post_widget.dart';

import '../../home/home_store.dart';
import 'stories_view_widget.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({Key? key}) : super(key: key);

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  final ArticlesProvider _articlesProvider = ArticlesProvider();
  final AdvertisementProvider _advertisementProvider = AdvertisementProvider();

  final HomeStore _homeStore = Modular.get();

  int _page = 0;
  List _posts = [];
  List<AdvertisementModel> _advertisements = [];
  bool _isFirstLoading = true;
  bool _isMoreLoading = false;
  bool _hasNextPage = true;
  late ScrollController _scrollController;

  void _firsLoad() async {
    List<ArticlesModel> articles = await _articlesProvider.getWall();
    _advertisements = await _advertisementProvider.getAdvertisements();
    _advertisements = _advertisements.where((a) => !a.isVideo).toList();
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
      List<Widget> advertisementWidgets = _advertisements
          .map(((e) => AdvertisementWidget(advertisement: e)))
          .toList();
      List<Widget> interleavedWidgets =
          interleavedPosts(postsWidgets, advertisementWidgets);

      return ListView(
        shrinkWrap: true,
        controller: _scrollController,
        children: [
          _header(),
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
          ...interleavedWidgets,
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

  List<Widget> interleavedPosts(
      List<Widget> posts, List<Widget> advertisements) {
    // Create a new list by interleaving 1 AdvertisementWidget for each 4 PostWidgets
    List<Widget> interleavedList = [];

    for (int i = 0; i < posts.length; i++) {
      interleavedList.add(posts[i]);

      // Add an AdvertisementWidget after every 4th PostWidget
      if ((i + 1) % 4 == 0 && (i + 1) < posts.length) {
        int adIndex = (i + 1) ~/ 4 - 1;
        // Repeat the advertisements if required
        interleavedList.add(advertisements[adIndex % advertisements.length]);
      }
    }

    return interleavedList;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.appLocalizations?.community ?? ''),
          _homeStore.loggedUser != null
              ? Text(
                  "${context.appLocalizations?.community_welcome}, ${_homeStore.loggedUser?.name.split(' ').first}",
                  style: context.textTheme.headline1,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
