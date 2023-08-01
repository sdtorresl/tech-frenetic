import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/widgets/separator.dart';

import '../../../widgets/separator_image_widget.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    var image1Width = (screenWidth * 0.8).round();
    var image1Height = (image1Width / 3).round();
    var image2Width = (screenWidth * 0.7 / 2).round();
    var image2Height = (screenWidth * 0.7 / 3).round();
    var image3Width = (screenWidth / 4).round();

    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromRGBO(0, 112, 232, 1),
          Color.fromRGBO(106, 60, 204, 1),
        ],
      )),
      child: Column(
        children: [
          Text(
            context.appLocalizations?.tech_events.split(" ")[0] ?? '',
            style: context.textTheme.headline1?.copyWith(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            context.appLocalizations?.tech_events.split(" ")[1] ?? '',
            style: context.textTheme.headline1?.copyWith(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Separator(
            separatorWidth: 2 / 3 * screenWidth,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              children: [
                Text(
                  context.appLocalizations?.events_description ?? '',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  context.appLocalizations?.events_description_bold ?? '',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: (screenWidth * 0.8 / 3) + (screenWidth * 0.7 / 3) + 40,
            child: Stack(
              children: [
                Positioned(
                  child: SizedBox(
                    width: image1Width.toDouble(),
                    height: image1Height.toDouble(),
                    child: SeparatorImageWidget(
                      image: 'assets/img/events/startupgrind.png',
                    ),
                  ),
                ),
                Positioned(
                  top: image1Width / 3 + 20,
                  left: image2Width * 0.2,
                  child: SizedBox(
                    width: image2Width.toDouble(),
                    height: image2Height.toDouble(),
                    child: SeparatorImageWidget(
                      image: 'assets/img/events/crunch1.jpg',
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: image3Width * 0.2,
                  child: SizedBox(
                    width: image3Width.toDouble(),
                    height: image3Width.toDouble(),
                    child: SeparatorImageWidget(
                      image: 'assets/img/events/grind2.jpg',
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
