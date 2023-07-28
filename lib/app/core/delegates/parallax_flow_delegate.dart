import 'package:flutter/material.dart';

class ParallaxFlowDelegate extends FlowDelegate {
  final ScrollableState? scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  ParallaxFlowDelegate(
      {required this.scrollable,
      required this.listItemContext,
      required this.backgroundImageKey})
      : super(repaint: scrollable?.position);

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    if (scrollable != null &&
        scrollable?.context.findRenderObject() != null &&
        listItemContext.findRenderObject() != null) {
      RenderBox scrollableBox =
          scrollable?.context.findRenderObject() as RenderBox;
      RenderBox listItemBox = listItemContext.findRenderObject() as RenderBox;
      Offset listItemOffset = listItemBox.localToGlobal(
          listItemBox.size.centerLeft(Offset.zero),
          ancestor: scrollableBox);

      // Determine the percent position of this list item within the
      // scrollable area.
      double viewportDimension = scrollable!.position.viewportDimension;
      final scrollFraction =
          (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

      // Calculate the vertical alignment of the background
      // based on the scroll percent.
      final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

      // Convert the background alignment into a pixel offset for
      // painting purposes.
      if (backgroundImageKey.currentContext?.findRenderObject() != null) {
        Size backgroundSize =
            (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
                .size;
        final listItemSize = context.size;
        final childRect = verticalAlignment.inscribe(
            backgroundSize, Offset.zero & listItemSize);

        // Paint the background.
        context.paintChild(
          0,
          transform:
              Transform.translate(offset: Offset(0.0, childRect.top)).transform,
        );
        return;
      }
    }

    context.paintChild(0, transform: Matrix4.identity());
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}
