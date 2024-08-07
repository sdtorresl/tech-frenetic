import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techfrenetic/app/core/utils.dart';
import 'package:techfrenetic/app/providers/video_provider.dart';
import 'package:video_player/video_player.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({Key? key, required this.videoFile}) : super(key: key);

  final XFile videoFile;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage>
    with TickerProviderStateMixin {
  final VideoProvider _videoProvider = VideoProvider();
  late VideoPlayerController _videoPlayerController;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Timer timer;
  int elapsedSeconds = 0;
  bool _isUploading = false;
  String? _progress;

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
  }

  void initializePlayer() {
    _videoPlayerController =
        VideoPlayerController.file(File(widget.videoFile.path))
          ..initialize().then((value) {
            _videoPlayerController.play();

            timer = Timer.periodic(const Duration(milliseconds: 500), (value) {
              if (mounted) {
                setState(() {
                  elapsedSeconds =
                      _videoPlayerController.value.position.inSeconds;
                });
              }
            });

            if (mounted) {
              setState(() {});
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: GestureDetector(
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
                  : const SizedBox.shrink(),
            ),
          ),
          Positioned(
            child: Container(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Modular.to.pop(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7.5),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 0, 0, 0.5),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        elapsedTime(elapsedSeconds.toInt()),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: _playButton(),
          ),
          _loading()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isUploading = true;
          });

          _videoProvider.uploadVideo(widget.videoFile, onComplete, onProgress);
        },
        child: const Icon(Icons.send),
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

  Widget _loading() {
    return _isUploading
        ? Positioned(
            child: Container(
              color: const Color.fromRGBO(0, 0, 0, 0.5),
              child: Center(
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        _progress ?? "0%",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  void onComplete(String? videoId) {
    setState(() {
      _isUploading = false;
    });

    Modular.to.pushNamed('/');

    const snackBar = SnackBar(
      content: Text('Your video was uploaded!'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void onProgress(double progress) {
    setState(() {
      _progress = progress.toStringAsFixed(2) + '%';
    });
  }
}
