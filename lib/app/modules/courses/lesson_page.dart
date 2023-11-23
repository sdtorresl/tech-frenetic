import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/video_model.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';
import 'package:techfrenetic/app/widgets/video_player_widget.dart';

class LessonPage extends StatefulWidget {
  const LessonPage(
      {Key? key,
      required this.title,
      required this.video,
      required this.description})
      : super(key: key);

  final String title;
  final String description;
  final VideoModel video;

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TFAppBar(
          title: Text(
        widget.title,
        style: Theme.of(context)
            .textTheme
            .headline1
            ?.copyWith(color: Theme.of(context).primaryColor),
      )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VideoPlayerWidget(url: widget.video.playback!.hls),
          Padding(
            padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
            child: Text(widget.description),
          )
        ],
      ),
    );
  }
}
