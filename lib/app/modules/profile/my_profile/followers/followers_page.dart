import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';

class FollowersPage extends StatelessWidget {
  final List<UserModel> following;
  final List<UserModel> followers;

  const FollowersPage(
      {Key? key, required this.following, required this.followers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TFAppBar(),
      body: Column(
        children: const [
          Text("Followers Page"),
        ],
      ),
    );
  }
}
