import 'package:cached_network_image/cached_network_image.dart';
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

class _AvatarWidgetState extends State<AvatarWidget>
    with TickerProviderStateMixin {
  final _prefs = UserPreferences();
  final UserProvider _userProvider = UserProvider();
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 250), vsync: this);
    _controller.forward();

    super.initState();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userId == _prefs.userId && _prefs.userAvatar.isNotEmpty) {
      return CircleAvatar(
        radius: widget.radius,
        backgroundColor: Colors.grey[200],
        child: ClipOval(
          child: SvgPicture.asset(
            "assets/img/avatars/${_prefs.userAvatar.isNotEmpty ? _prefs.userAvatar : 'avatar-01'}.svg",
            semanticsLabel: _prefs.userName,
          ),
        ),
      );
    }

    return FutureBuilder(
      future: _userProvider.getUser(widget.userId),
      builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
        UserModel user = UserModel.empty();

        if (snapshot.hasData) {
          user = snapshot.data!;

          _controller.reset();
          _controller.forward();

          if (user.useAvatar) {
            return CircleAvatar(
              radius: widget.radius,
              backgroundColor: Colors.grey[200],
              child: ScaleTransition(
                scale: Tween(begin: 0.0, end: 1.0).animate(_controller),
                child: ClipOval(
                  child: SvgPicture.asset(
                    "assets/img/avatars/${user.avatar.isNotEmpty ? user.avatar : 'avatar-01'}.svg",
                    semanticsLabel: user.name,
                  ),
                ),
              ),
            );
          } else {
            return CircleAvatar(
              radius: widget.radius,
              backgroundColor: Colors.grey[200],
            );
            /* return CircleAvatar(
              radius: widget.radius,
              backgroundColor: Colors.grey[200],
              child: ScaleTransition(
                scale: Tween(begin: 0.0, end: 1.0).animate(_controller),
                child: ClipOval(
                  child: CachedNetworkImage(imageUrl: user.picture.first.url),
                ),
              ),
            ); */
          }
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
