import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/utils.dart';
import 'package:techfrenetic/app/models/video_model.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';
import 'package:video_player/video_player.dart';

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
  late VideoPlayerController _controller;
  int elapsedSeconds = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.video.playback!.hls)
      ..initialize().then((_) {
        _controller.addListener(updateElapsedTime);

        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.removeListener(updateElapsedTime);
    super.dispose();
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
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Stack(
                      children: [
                        VideoPlayer(_controller),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          right: 0,
                          child: _controlBar(),
                        )
                      ],
                    ),
                  )
                : const CircularProgressIndicator(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
            child: Text(widget.description),
          )
        ],
      ),
    );
  }

  Widget _controlBar() {
    return Container(
      color: const Color.fromRGBO(0, 0, 0, 0.4),
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            splashRadius: 5,
            iconSize: 25,
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            icon: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
          ),
          IconButton(
            splashRadius: 5,
            iconSize: 20,
            onPressed: () {
              setState(() {
                _controller.value.volume == 0
                    ? _controller.setVolume(1)
                    : _controller.setVolume(0);
              });
            },
            icon: Icon(
              _controller.value.volume == 0
                  ? Icons.volume_mute
                  : Icons.volume_up,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Text(
            elapsedTime(_controller.value.position.inSeconds.toInt()),
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }

  void updateElapsedTime() {
    if (elapsedSeconds != _controller.value.position.inSeconds && mounted) {
      setState(() {
        elapsedSeconds = _controller.value.position.inSeconds;
      });
    }
  }
}
