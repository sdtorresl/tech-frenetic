import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';

class ArticleImagePage extends StatelessWidget {
  final String url;

  const ArticleImagePage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TFAppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Theme.of(context).primaryColorDark,
        foregroundColor: Colors.white,
      ),
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: PhotoView(
          backgroundDecoration: const BoxDecoration(color: Colors.white),
          heroAttributes: const PhotoViewHeroAttributes(tag: "articleImage"),
          imageProvider: CachedNetworkImageProvider(
            url,
          ),
        ),
      ),
    );
  }
}
