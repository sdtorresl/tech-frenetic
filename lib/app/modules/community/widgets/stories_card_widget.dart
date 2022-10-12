import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/models/video_model.dart';

class StoryCardWidget extends StatelessWidget {
  const StoryCardWidget({
    Key? key,
    required this.video,
    required this.width,
    required this.cardsInView,
  }) : super(key: key);

  final VideoModel video;
  final double width;
  final int cardsInView;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: () => Modular.to.pushNamed(
          '/stories',
          arguments: video,
        ),
        child: Container(
          margin: EdgeInsets.only(right: width / (cardsInView * 2)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColorLight,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(1, 1), // changes position of shadow
                ),
              ]),
          width: width,
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: CachedNetworkImage(
                  imageUrl: video.thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(0, 0, 0, 0),
                      Color.fromRGBO(0, 0, 0, 0.6),
                    ],
                  ),
                ),
              )),
              Positioned(
                bottom: 15,
                left: 20,
                right: 20,
                child: Text(
                  video.meta?.author ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
