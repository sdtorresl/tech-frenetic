import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  const Separator({
    Key? key,
    required this.separatorWidth,
  }) : super(key: key);

  final double separatorWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Theme.of(context).primaryColor,
        width: separatorWidth,
        height: 1.5,
      ),
    );
  }
}
