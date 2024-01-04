import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/advertisement_model.dart';

class AdvertisementWidget extends StatefulWidget {
  final AdvertisementModel advertisement;
  const AdvertisementWidget({super.key, required this.advertisement});

  @override
  State<AdvertisementWidget> createState() => _AdvertisementWidgetState();
}

class _AdvertisementWidgetState extends State<AdvertisementWidget> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    if (!widget.advertisement.isVideo && isVisible) {
      return Container(
        color: Colors.black,
        width: double.infinity,
        child: Stack(
          children: [
            GestureDetector(
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: widget.advertisement.picture!,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isVisible = false;
                  });
                },
              ),
              top: 5,
              right: 5,
            )
          ],
        ),
      );
    }
    return const SizedBox();
  }
}
