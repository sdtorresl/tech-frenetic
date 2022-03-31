import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/videos/videos_controller.dart';

class VideosPage extends StatefulWidget {
  final String title;
  const VideosPage({Key? key, this.title = 'VideoPage'}) : super(key: key);
  @override
  VideosPageState createState() => VideosPageState();
}

class VideosPageState extends ModularState<VideosPage, VideosController> {
  CameraController? _controller;
  late Future<void> _initializeControllerFuture;
  bool isRecording = false;
  late Timer timer;
  int elapsedSeconds = 0;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller!.dispose();
    }
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    final CameraController? cameraController = _controller;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(80, 80, 80, 0.7),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: cameraController != null
                ? FutureBuilder<void>(
                    future: _initializeControllerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return SafeArea(
                          child: Center(
                            child: CameraPreview(cameraController),
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
          Positioned(
            left: 20,
            top: 20,
            child: SafeArea(
              child: IconButton(
                onPressed: () => Modular.to.pop(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 20,
            child: SafeArea(
              child: Text(
                elapsedTime(elapsedSeconds),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ),
          Positioned(
            bottom: 45,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onLongPress: cameraController != null &&
                        cameraController.value.isInitialized &&
                        !cameraController.value.isRecordingVideo
                    ? onVideoRecordButtonPressed
                    : null,
                onLongPressUp: cameraController != null &&
                        cameraController.value.isInitialized &&
                        cameraController.value.isRecordingVideo
                    ? onStopButtonPressed
                    : null,
                child: isRecording
                    ? const Icon(
                        Icons.radio_button_off,
                        size: 70,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.panorama_fisheye,
                        size: 70,
                        color: Colors.white,
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void initializeCamera() async {
    List<CameraDescription> cameras = await availableCameras();
    _controller = CameraController(
      cameras[0],
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  void onVideoRecordButtonPressed() {
    debugPrint("Start recording...");
    startVideoRecording().then((_) {
      if (mounted) {
        setState(() {
          isRecording = true;
        });
      }
    });
  }

  void onStopButtonPressed() {
    debugPrint("Stop recording...");
    stopVideoRecording().then((XFile? file) {
      if (mounted) {
        setState(() {
          isRecording = false;
        });
      }
      if (file != null) {
        debugPrint('Video recorded to ${file.path}');
        Modular.to.pushNamed('/community/video/preview', arguments: file);
      }
    });
  }

  Future<void> startVideoRecording() async {
    final CameraController? cameraController = _controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      debugPrint('Error: select a camera first.');
      return;
    }

    if (cameraController.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return;
    }

    try {
      elapsedSeconds = 0;
      timer = Timer.periodic(const Duration(seconds: 1), (value) {
        debugPrint("Elapsed time: $elapsedSeconds");
        if (mounted) {
          setState(() {
            elapsedSeconds += 1;
          });
        }
      });
      await cameraController.startVideoRecording();
    } on CameraException catch (e) {
      debugPrint(e.toString());
      return;
    }
  }

  Future<XFile?> stopVideoRecording() async {
    if (_controller == null || !_controller!.value.isRecordingVideo) {
      return null;
    }

    try {
      timer.cancel();
      return _controller!.stopVideoRecording();
    } on CameraException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  String elapsedTime(int elapsedSeconds) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    Duration duration = Duration(seconds: elapsedSeconds);
    String hours = twoDigits(duration.inHours.remainder(60));
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return isRecording ? "$hours:$minutes:$seconds" : "";
  }
}
