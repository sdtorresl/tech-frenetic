import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/core/utils.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget(
      {Key? key,
      required this.url,
      this.advertisement =
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      this.autoplay = true})
      : super(key: key);

  final String url;
  final String? advertisement;
  final bool autoplay;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  bool _isAdvertisement = false;
  bool _canSkip = false;
  int elapsedSeconds = 0;
  final minAddDuration = 3;

  @override
  void initState() {
    super.initState();

    if (widget.advertisement != null) {
      _initializeAd();
    } else {
      _initializeVideo();
    }

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

  void _initializeAd() {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.advertisement!),
    )..initialize().then((_) {
        if (widget.autoplay) {
          _controller.play();
        }
        _controller.addListener(_updateElapsedTime);
        _controller.addListener(_checkAdvertisement);
        setState(() {
          _isAdvertisement = true;
        });
      }).catchError((error) {
        debugPrint(error);
      });
  }

  void _initializeVideo() {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
    )..initialize().then((_) {
        _controller.addListener(_updateElapsedTime);
        if (widget.autoplay) {
          _controller.play();
        }
        setState(() {
          _isAdvertisement = false;
        });
      }).catchError((error) {
        debugPrint(error);
      });
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
          ? Container(
              height: 200,
              width: double.infinity,
              color: Colors.black,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    bottom: 0,
                    right: 0,
                    top: 0,
                    child: ClipRRect(
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                    ),
                  ),
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
                  ),
                  _skipAdButton(),
                ],
              ),
            )
          : Container(
              margin: const EdgeInsetsDirectional.all(50),
              width: double.infinity,
              child: const Center(child: CircularProgressIndicator()),
            ),
    );
  }

  Widget _controlBar() {
    return Container(
      color: const Color.fromRGBO(0, 0, 0, 0.4),
      padding: const EdgeInsets.only(right: 20),
      child: SafeArea(
        bottom: false,
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
      ),
    );
  }

  Widget _skipAdButton() {
    return _isAdvertisement && _canSkip
        ? Positioned(
            top: 5,
            right: 5,
            child: ElevatedButton(
              onPressed: _initializeVideo,
              child: Text(
                "Skip",
                style:
                    context.textTheme.bodyMedium?.copyWith(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
            ),
          )
        : const SizedBox.shrink();
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

  void _checkAdvertisement() {
    if (_controller.value.position.inSeconds >= minAddDuration ||
        _controller.value.duration.inSeconds < minAddDuration) {
      setState(() {
        _canSkip = true;
      });
    }
    if (_controller.value.position.inSeconds ==
        _controller.value.duration.inSeconds) {
      debugPrint("Ad finished!");
      _initializeVideo();
    }
  }
}
