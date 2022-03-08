import 'package:flutter/material.dart';
import 'package:techfrenetic/app/modules/profile/my_profile/my_profile_page.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';

class UserProfilePage extends StatelessWidget {
  final String userId;

  const UserProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TFAppBar(),
      body: MyProfilePage(
        userId: userId,
      ),
    );
  }
}
