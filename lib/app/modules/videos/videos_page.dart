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
      body: Stack(
        children: [
          Positioned(
            child: Container(
              color: const Color.fromRGBO(0, 0, 0, 0.5),
            ),
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
            bottom: 45,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                height: 100,
                width: 100,
                padding: const EdgeInsets.all(5),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black,
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
