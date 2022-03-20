import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/video_model.dart';
import 'package:techfrenetic/app/modules/community/widgets/stories_card_widget.dart';
import 'package:techfrenetic/app/providers/video_provider.dart';

class StoriesViewWidget extends StatelessWidget {
  StoriesViewWidget({Key? key}) : super(key: key);

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  @override
  Widget build(BuildContext context) {
    int cardsInView = 3;
    double width = MediaQuery.of(context).size.width / cardsInView;
    double height = width * 6 / 4;
    VideoProvider videoProvider = VideoProvider();

    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: FutureBuilder(
        future: videoProvider.getVideos(),
        builder:
            (BuildContext context, AsyncSnapshot<List<VideoModel>> snapshot) {
          if (snapshot.hasData) {
            List<VideoModel> videos = snapshot.data!;

            return ListView(
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
