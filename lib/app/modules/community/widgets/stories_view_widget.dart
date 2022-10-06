import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/video_model.dart';
import 'package:techfrenetic/app/modules/community/widgets/stories_card_widget.dart';
import 'package:techfrenetic/app/providers/video_provider.dart';

class StoriesViewWidget extends StatelessWidget {
  final int? userId;
  const StoriesViewWidget({Key? key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int cardsInView = 3;
    double width = MediaQuery.of(context).size.width / cardsInView;
    double height = width * 6 / 4;
    VideoProvider videoProvider = VideoProvider();

    return FutureBuilder(
      future: videoProvider.getVideos(userId: userId),
      builder:
          (BuildContext context, AsyncSnapshot<List<VideoModel>> snapshot) {
        if (snapshot.hasData) {
          List<VideoModel> videos = snapshot.data!;

          if (videos.isEmpty) {
            return const SizedBox();
          }

          return Container(
            height: height,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: videos
                  .map(
                    (video) => StoryCardWidget(
                      video: video,
                      width: width,
                      cardsInView: cardsInView,
                    ),
                  )
                  .toList(),
            ),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
