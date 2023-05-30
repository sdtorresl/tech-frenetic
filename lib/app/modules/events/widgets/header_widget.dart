import 'package:flutter/material.dart';
import 'package:techfrenetic/app/widgets/separator.dart';

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
            "Tech",
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
          ),
          Text(
            "Events",
            style: Theme.of(context).textTheme.headline1?.copyWith(
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
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Velit erat velit ornare aliquam, consect. Edit consectetum alit ediam venut!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
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
                    child: Image.network(
                      "https://picsum.photos/$image1Width/$image1Height",
                    ),
                  ),
                ),
                Positioned(
                  top: image1Width / 3 + 20,
                  left: image2Width * 0.2,
                  child: SizedBox(
                    width: image2Width.toDouble(),
                    height: image2Height.toDouble(),
                    child: Image.network(
                      "https://picsum.photos/$image2Width/$image2Height",
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: image3Width * 0.2,
                  child: SizedBox(
                    width: image3Width.toDouble(),
                    height: image3Width.toDouble(),
                    child: Image.network(
                      "https://picsum.photos/$image2Width/$image2Width",
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
