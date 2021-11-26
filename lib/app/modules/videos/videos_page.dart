import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/videos/videos_controller.dart';

class VideosPage extends StatefulWidget {
  final String title;
  const VideosPage({Key? key, this.title = 'VideoPage'}) : super(key: key);
  @override
  VideosPageState createState() => VideosPageState();
}

class VideosPageState extends ModularState<VideosPage, VideosController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
