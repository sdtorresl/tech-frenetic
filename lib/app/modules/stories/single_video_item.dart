import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/video_model.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_player/video_player.dart';

class SingleVideoItem extends StatefulWidget {
  const SingleVideoItem({
    Key? key,
    required this.videoItem,
  }) : super(key: key);

  final VideoModel videoItem;

  @override
  State<SingleVideoItem> createState() => _SingleVideoItemState();
}

class _SingleVideoItemState extends State<SingleVideoItem>
    with TickerProviderStateMixin {
  late VideoPlayerController _videoPlayerController;
  bool isMuted = false;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    initializePlayer();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 125),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
    //_animationController.forward();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void initializePlayer() {
    _videoPlayerController =
        VideoPlayerController.network(widget.videoItem.playback!.hls)
          ..initialize().then((value) {
            _videoPlayerController.play();
            _videoPlayerController.setLooping(true);
            setState(() {
              isMuted = _videoPlayerController.value.volume == 0;
            });
          });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(bottom: 0, top: 0, right: 0, left: 0, child: _videoPlayer()),
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          child: _header(),
        ),
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
          child: _playButton(),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _options(),
        )
      ],
    );
  }

  Widget _playButton() {
    return Center(
      child: ScaleTransition(
        scale: _animation,
        child: IconButton(
          onPressed: () => _playPause(),
          iconSize: 100,
          icon: const Icon(
            Icons.play_arrow,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(0, 0, 0, 0.6),
            Color.fromRGBO(0, 0, 0, 0.5),
            Color.fromRGBO(0, 0, 0, 0.4),
            Colors.transparent,
          ],
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              onPressed: () => Modular.to.pop(),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.videoItem.meta != null
                  ? widget.videoItem.meta!.name ?? ''
                  : '',
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.white, fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }

  Widget _videoPlayer() {
    return GestureDetector(
      onTap: () => _playPause(),
      child: _videoPlayerController.value.isInitialized
          ? SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _videoPlayerController.value.size.width,
                  height: _videoPlayerController.value.size.height,
                  child: VideoPlayer(_videoPlayerController),
                ),
              ),
            )
          : CachedNetworkImage(
              imageUrl: widget.videoItem.thumbnail,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, state, progress) => Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    value: progress.progress,
                  ),
                ),
              ),
            ),
    );
  }

  Widget _options() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Color.fromRGBO(0, 0, 0, 0.4),
            Color.fromRGBO(0, 0, 0, 0.5),
            Color.fromRGBO(0, 0, 0, 0.6),
          ],
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                isMuted
                    ? _videoPlayerController.setVolume(100)
                    : _videoPlayerController.setVolume(0);
                setState(() {
                  isMuted = !isMuted;
                });
              },
              icon: Icon(
                isMuted ? Icons.volume_mute : Icons.volume_up,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.videoItem.meta!.author ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white),
                ),
                Text(
                  timeago.format(widget.videoItem.created),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _playPause() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.isPlaying) {
        _videoPlayerController.pause();
        _animationController.forward();
      } else {
        _videoPlayerController.play();
        _animationController.reverse();
      }
      setState(() {});
    }
  }
}
