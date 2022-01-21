import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  final prefs = UserPreferences();

  late Future<UserModel?> user;
  late AnimationController _controller;

  @override
  void initState() {
    UserProvider userProvider = UserProvider();
    user = userProvider.getUser(widget.userId);

    _controller = AnimationController(
        duration: const Duration(milliseconds: 250), vsync: this);
    _controller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      future: user,
      builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
        if (snapshot.hasData) {
          UserModel user = snapshot.data!;
          _controller.reset();
          _controller.forward();

          return CircleAvatar(
            radius: widget.radius,
            backgroundColor: Colors.grey[200],
            child: ScaleTransition(
              scale: Tween(begin: 0.0, end: 1.0).animate(_controller),
              child: ClipOval(
                child: SvgPicture.asset(
                  "assets/img/avatars/${user.fieldUserAvatar.isNotEmpty ? user.fieldUserAvatar : 'avatar-01'}.svg",
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
        }
      },
    );
  }
}
