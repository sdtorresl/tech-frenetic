import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techfrenetic/app/core/user_preferences.dart';
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';

class AvatarWidget extends StatefulWidget {
  final String userId;
  final double radius;

  const AvatarWidget({
    Key? key,
    required this.userId,
    this.radius = 20,
  }) : super(key: key);

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  final prefs = UserPreferences();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = UserProvider();

    if (widget.userId == prefs.userId && prefs.userAvatar!.isNotEmpty) {
      return CircleAvatar(
        radius: widget.radius,
        backgroundColor: Colors.grey[200],
        child: ClipOval(
          child: SvgPicture.asset(
            "assets/img/avatars/${prefs.userAvatar!.isNotEmpty ? prefs.userAvatar : 'avatar-01'}.svg",
            semanticsLabel: prefs.userName,
          ),
        ),
      );
    }

    return FutureBuilder(
      future: userProvider.getUser(widget.userId),
      builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
        if (snapshot.hasData) {
          UserModel user = snapshot.data!;
          return CircleAvatar(
            radius: widget.radius,
            backgroundColor: Colors.grey[200],
            child: ClipOval(
              child: SvgPicture.asset(
                "assets/img/avatars/${user.fieldUserAvatar.isNotEmpty ? user.fieldUserAvatar : 'avatar-01'}.svg",
                semanticsLabel: user.name,
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
  }
}
