import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final String category;
  final double elevation;
  final Color color;
  final Color foregroundColor;

  const CategoryWidget({
    super.key,
    required this.category,
    this.elevation = 3,
    this.color = const Color(0xffddedfe),
    this.foregroundColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          category,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: foregroundColor),
        ),
      ),
    );
  }
}
