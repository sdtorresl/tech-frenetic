import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techfrenetic/app/models/video_model.dart';
import 'package:techfrenetic/app/modules/stories/single_video_item.dart';
import 'package:techfrenetic/app/providers/video_provider.dart';

class StoriesViewPage extends StatefulWidget {
  const StoriesViewPage({Key? key, required VideoModel video})
      : super(key: key);

  @override
  State<StoriesViewPage> createState() => _StoriesViewPageState();
}

class _StoriesViewPageState extends State<StoriesViewPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    VideoProvider videoProvider = VideoProvider();

    return Scaffold(
      body: FutureBuilder(
        future: videoProvider.getVideos(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<VideoModel> videos = snapshot.data;
            return Swiper(
              itemBuilder: (BuildContext context, int index) {
                return SingleVideoItem(
                  videoItem: videos[index],
                );
              },
              itemCount: videos.length,
              scrollDirection: Axis.vertical,
              // pagination:
              //     const SwiperPagination(alignment: Alignment.centerRight),
            );
          } else {
            return const Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
