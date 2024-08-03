import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/advertisement_model.dart';
import 'package:techfrenetic/app/widgets/video_player_widget.dart';

class VideoAdvertisementWidget extends StatefulWidget {
  const VideoAdvertisementWidget({
    Key? key,
    required AdvertisementModel video,
  })  : _video = video,
        super(key: key);

  final AdvertisementModel _video;

  @override
  State<VideoAdvertisementWidget> createState() =>
      _VideoAdvertisementWidgetState();
}

class _VideoAdvertisementWidgetState extends State<VideoAdvertisementWidget> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? Positioned(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(25),
                  padding: const EdgeInsets.all(10),
                  color: Colors.black,
                  child: Center(
                    child: VideoPlayerWidget(
                      url: widget._video.url!,
                      advertisement: widget._video.url!,
                    ),
                  ),
                ),
                Positioned(
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () => {
                      setState(() => isVisible = false),
                    },
                  ),
                  top: 20,
                  right: 20,
                )
              ],
            ),
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
          )
        : const SizedBox.shrink();
  }
}
