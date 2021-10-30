import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/articles_model.dart';

class ArticleWidget extends StatelessWidget {
  final ArticlesModel article;
  const ArticleWidget({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Article page!");
    return Scaffold();
  }
}
