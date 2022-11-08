import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  const CourseCard(
      {super.key,
      required this.imageUrl,
      required this.headline,
      this.subtitle});

  final String imageUrl;
  final String headline;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Stack(
        children: [
          Positioned(
            bottom: 20,
            top: 0,
            left: 0,
            right: 0,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 25,
            right: 25,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 1, spreadRadius: 1)
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Text(
                        headline,
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            ?.copyWith(color: Theme.of(context).primaryColor),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  subtitle != null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            subtitle!,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
