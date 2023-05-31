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

class VideosPageState extends State<VideosPage> with WidgetsBindingObserver {
  VideosController controller = Modular.get();
  CameraController? _controller;
  bool _isCameraInitialized = false;
  bool isRecording = false;
  bool _recordButtonVisible = false;
  Timer? timer;
  double elapsedSeconds = 0;
  bool _isRearCameraSelected = true;
  List<CameraDescription>? cameras;

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
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    final CameraController? cameraController = _controller;

    return Scaffold(
      backgroundColor: Colors.black12,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: cameraController != null
                ? _isCameraInitialized
                    ? SafeArea(
                        child: Center(
                          child: CameraPreview(cameraController),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      )
                : const Center(child: CircularProgressIndicator()),
          ),
          Positioned(
            left: 20,
            top: 20,
            child: SafeArea(
                child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.circle,
                  color: Colors.black38,
                  size: 50,
                ),
                Positioned(
                  left: 7,
                  child: IconButton(
                    onPressed: () => Modular.to.pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            )),
          ),
          Positioned(
            right: 20,
            top: 20,
            child: SafeArea(
              child: isRecording
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7.5),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 0, 0, 0.5),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: [
                          AnimatedOpacity(
                            opacity: _recordButtonVisible ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 250),
                            child: const Icon(
                              Icons.fiber_manual_record,
                              color: Colors.red,
                              size: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            elapsedTime(elapsedSeconds.toInt()),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 90,
                  ),
                  _recordButton(cameraController),
                  const SizedBox(
                    width: 40,
                  ),
                  _toggleCameraButton()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _toggleCameraButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isCameraInitialized = false;
        });
        onNewCameraSelected(
          cameras![_isRearCameraSelected ? 0 : 1],
        );
        setState(() {
          _isRearCameraSelected = !_isRearCameraSelected;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(50),
        ),
        width: 50,
        height: 50,
        child: Icon(
          _isRearCameraSelected ? Icons.camera_front : Icons.camera_rear,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  Widget _recordButton(CameraController? cameraController) {
    return GestureDetector(
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
    );
  }

  void initializeCamera() async {
    cameras = await availableCameras();
    if (cameras != null) {
      onNewCameraSelected(cameras![0]);
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    previousCameraController.dispose();

    // Replace with the new controller
    if (mounted) {
      setState(() {
        _controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    // Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      debugPrint('Error initializing camera: $e');
    }

    // Update the Boolean
    if (mounted) {
      setState(() {
        _isCameraInitialized = _controller!.value.isInitialized;
      });
    }
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

      timer = Timer.periodic(const Duration(milliseconds: 500), (value) {
        debugPrint("Elapsed time: $elapsedSeconds");
        if (mounted) {
          setState(() {
            elapsedSeconds += 0.5;
            _recordButtonVisible = !_recordButtonVisible;
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
      setState(() {
        _recordButtonVisible = false;
      });
      if (timer != null) {
        timer!.cancel();
      }
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
    return isRecording ? "$hours:$minutes:$seconds" : "00:00:10";
  }
}
