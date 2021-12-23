import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techfrenetic/app/models/profile_model.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';

class UserAvatarWidget extends StatefulWidget {
  final String username;
  final double radius;

  const UserAvatarWidget({
    Key? key,
    required this.username,
    this.radius = 20,
  }) : super(key: key);

  @override
  State<UserAvatarWidget> createState() => _UserAvatarWidgetState();
}

class _UserAvatarWidgetState extends State<UserAvatarWidget> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = UserProvider();
    return FutureBuilder(
      future: userProvider.getProfile(widget.username),
      initialData: ProfileModel.empty(),
      builder: (BuildContext context, AsyncSnapshot<ProfileModel?> snapshot) {
        if (snapshot.hasData) {
          ProfileModel userProfile = snapshot.data!;
          if (userProfile.useAvatar) {
            return CircleAvatar(
              radius: widget.radius,
              backgroundColor: Colors.grey[200],
              child: ClipOval(
                child: SvgPicture.asset(
                  "assets/img/avatars/${userProfile.avatar}.svg",
                  semanticsLabel: userProfile.name,
                ),
              ),
            );
          } else {
            return CircleAvatar(
              radius: widget.radius,
              backgroundColor: Colors.grey[200],
              child: ClipOval(
                child: SvgPicture.asset(
                  "assets/img/avatars/avatar-01.svg",
                  semanticsLabel: userProfile.name,
                ),
              ),
            );
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
