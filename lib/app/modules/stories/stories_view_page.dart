import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/models/video_model.dart';

class StoriesViewPage extends StatefulWidget {
  const StoriesViewPage({Key? key, required VideoModel video})
      : super(key: key);

  @override
  State<StoriesViewPage> createState() => _StoriesViewPageState();
}

class _StoriesViewPageState extends State<StoriesViewPage> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      body: Stack(
        children: [
          Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                imgList[index],
                fit: BoxFit.cover,
              );
            },
            itemCount: imgList.length,
            scrollDirection: Axis.vertical,
            pagination:
                const SwiperPagination(alignment: Alignment.centerRight),
          ),
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.8),
                    Color.fromRGBO(0, 0, 0, 0.4),
                    Color.fromRGBO(0, 0, 0, 0.2),
                    Colors.transparent,
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
                      "Hola",
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: Colors.white, fontSize: 25),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
