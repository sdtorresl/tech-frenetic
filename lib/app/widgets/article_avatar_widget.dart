import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techfrenetic/app/core/user_preferences.dart';
import 'package:techfrenetic/app/models/article_user_model.dart';
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:techfrenetic/app/providers/articles_provider.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';

class ArticleAvatar extends StatefulWidget {
  final String articleUrl;
  final double radius;

  const ArticleAvatar({
    Key? key,
    required this.articleUrl,
    this.radius = 20,
  }) : super(key: key);

  @override
  State<ArticleAvatar> createState() => _ArticleAvatarState();
}

class _ArticleAvatarState extends State<ArticleAvatar> {
  final prefs = UserPreferences();

  @override
  Widget build(BuildContext context) {
    ArticlesProvider articlesProvider = ArticlesProvider();
    UserProvider userProvider = UserProvider();
    return FutureBuilder(
      future: articlesProvider.getUserByArticle(widget.articleUrl),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          UserByArticleModel user = snapshot.data;
          return FutureBuilder(
            future: userProvider.getUser(user.targetId),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              UserModel userInfo;
              if (snapshot.hasData) {
                debugPrint(snapshot.data.toString());
                userInfo = snapshot.data;
                debugPrint(userInfo.fieldUserAvatar);
                return CircleAvatar(
                  radius: widget.radius,
                  backgroundColor: Colors.grey[200],
                  child: ClipOval(
                    child: SvgPicture.asset(
                      "assets/img/avatars/${userInfo.fieldUserAvatar}.svg",
                      semanticsLabel: userInfo.name,
                    ),
                  ),
                );
              } else {
                return CircleAvatar(
                  radius: widget.radius,
                  backgroundColor: Colors.grey[200],
                );
              }
            },
          );
        } else {
          return CircleAvatar(
            radius: widget.radius,
            backgroundColor: Colors.grey[200],
          );
        }
      },
    );
  }
}
