import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:techfrenetic/app/widgets/avatar_widget.dart';

class UserItemWidget extends StatelessWidget {
  final UserModel user;
  const UserItemWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Row(
        children: [
          AvatarWidget(
            userId: user.uid.toString(),
            radius: 35,
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: Theme.of(context).textTheme.headline3,
                softWrap: true,
              ),
              Text(
                user.profession,
                style: Theme.of(context).textTheme.bodyText2,
                softWrap: true,
              )
            ],
          )
        ],
      ),
    );
  }
}
