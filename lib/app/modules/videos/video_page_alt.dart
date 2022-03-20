import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_camera/flutter_camera.dart';

class CameraApp extends StatefulWidget {
  const CameraApp({Key? key}) : super(key: key);

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterCamera(
      color: Theme.of(context).colorScheme.primary,
      onVideoRecorded: (value) {
        final path = value.path;
        print('::::::::::::::::::::::::;; dkdkkd $path');
      },
    );
  }
}
