import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({Key? key, required this.videoFile}) : super(key: key);

  final XFile videoFile;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage>
    with TickerProviderStateMixin {
  late VideoPlayerController _videoPlayerController;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Timer timer;
  int elapsedSeconds = 0;
  bool _isUploading = false;

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

            timer = Timer.periodic(const Duration(milliseconds: 250), (value) {
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
                    Text(
                      _elapsedTime(elapsedSeconds),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                          ),
                    )
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

          Future.delayed(const Duration(seconds: 1)).then((value) {
            setState(() {
              _isUploading = false;
            });

            Modular.to.pushNamed('/');

            const snackBar = SnackBar(
              content: Text('Your video was uploaded!'),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        },
        child: const Icon(Icons.send),
      ),
    );
  }

  String _elapsedTime(int elapsedSeconds) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    Duration duration = Duration(seconds: elapsedSeconds);
    String hours = twoDigits(duration.inHours.remainder(60));
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
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
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
