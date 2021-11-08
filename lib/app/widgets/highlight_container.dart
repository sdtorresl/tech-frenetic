import 'package:flutter/material.dart';

class HighlightContainer extends StatelessWidget {
  final Widget child;
  const HighlightContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: child,
    );
  }
}
