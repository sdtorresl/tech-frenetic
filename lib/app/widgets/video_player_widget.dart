import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/utils.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  int elapsedSeconds = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.url,
    )..initialize().then((_) {
        _controller.addListener(_updateElapsedTime);
        setState(() {});
      });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.removeListener(_updateElapsedTime);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_animationController.status == AnimationStatus.completed) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      },
      onDoubleTap: () => _togglePlay(),
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
                    child: ClipRect(
                      child: SlideTransition(
                        position: _animation,
                        child: _controlBar(),
                      ),
                    ),
                  )
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _controlBar() {
    return Container(
      color: const Color.fromRGBO(0, 0, 0, 0.4),
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        children: [
          IconButton(
            splashRadius: 5,
            iconSize: 25,
            onPressed: () => _togglePlay(),
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

  void _togglePlay() {
    if (_controller.value.isInitialized) {
      !_controller.value.isPlaying ? _controller.play() : _controller.pause();
      setState(() {});
    }
  }

  void _updateElapsedTime() {
    if (elapsedSeconds != _controller.value.position.inSeconds && mounted) {
      setState(() {
        elapsedSeconds = _controller.value.position.inSeconds;
      });
    }
  }
}
