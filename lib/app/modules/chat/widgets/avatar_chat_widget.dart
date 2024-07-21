import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AvatarChatWidget extends StatefulWidget {
  final String? url;
  final double radius;

  const AvatarChatWidget({
    Key? key,
    required this.url,
    this.radius = 20,
  }) : super(key: key);

  @override
  State<AvatarChatWidget> createState() => _AvatarChatWidgetState();
}

class _AvatarChatWidgetState extends State<AvatarChatWidget>
    with TickerProviderStateMixin {
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
    double pictureHeight = widget.radius * 2 - ((widget.radius * 2) * 0.15);
    double pictureWidth = pictureHeight;

    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: Colors.grey[200],
      child: ClipOval(
        child: SizedBox(
          height: pictureHeight,
          width: pictureWidth,
          child: widget.url != null
              ? widget.url!.toLowerCase().contains('svg')
                  ? SvgPicture.network(widget.url!)
                  : CachedNetworkImage(imageUrl: widget.url!)
              : const Icon(
                  Icons.person,
                ),
        ),
        // clipper: MyCustomClipper(widget.radius),
      ),
    );
  }
}
