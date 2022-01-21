import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  const Separator({
    Key? key,
    required this.separatorWidth,
    this.color,
    this.margin,
    this.height,
  }) : super(key: key);

  final double separatorWidth;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: margin ?? EdgeInsets.zero,
        color: color ?? Theme.of(context).primaryColor,
        width: separatorWidth,
        height: height ?? 1.5,
      ),
    );
  }
}
