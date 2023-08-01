import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/delegates/parallax_flow_delegate.dart';

class SeparatorImageWidget extends StatelessWidget {
  final GlobalKey _backgroundImageKey = GlobalKey();
  final String image;

  SeparatorImageWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    ScrollableState? scrollableState = Scrollable.of(context);

    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: scrollableState,
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        Image.asset(
          image,
          fit: BoxFit.cover,
          key: _backgroundImageKey,
        ),
      ],
    );
  }
}
