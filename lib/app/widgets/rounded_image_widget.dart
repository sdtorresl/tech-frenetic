import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    Key? key,
    required this.url,
    this.width = 100,
    this.height = 100,
  }) : super(key: key);

  final String url;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xff7c94b6),
        image: DecorationImage(
          image: CachedNetworkImageProvider(url),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(width)),
        border: Border.all(
          color: Colors.blue,
          width: 2.0,
        ),
      ),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xff7c94b6),
          image: DecorationImage(
            image: CachedNetworkImageProvider(url),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(width / 2)),
          border: Border.all(
            color: Colors.white,
            width: 4.0,
          ),
        ),
      ),
    );
  }
}
