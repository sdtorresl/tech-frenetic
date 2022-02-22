import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';

class UsersProfilesPage extends StatefulWidget {
  final ArticlesModel article;

  const UsersProfilesPage({Key? key, required this.article}) : super(key: key);

  @override
  _UsersProfilesPageState createState() => _UsersProfilesPageState();
}

class _UsersProfilesPageState extends State<UsersProfilesPage> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = UserProvider();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder(
        future: userProvider.getUser(widget.article.uid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          UserModel user;
          if (snapshot.hasData) {
            user = snapshot.data;

            return const SizedBox();

            //TODO: Fix this!!
            // return MyProfilePage(
            //   user: user,
            //   avatarId: user.uid,
            // );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
