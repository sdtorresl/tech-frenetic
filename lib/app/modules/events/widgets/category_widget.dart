import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final String category;
  final double elevation;

  const CategoryWidget({super.key, required this.category, this.elevation = 3});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: const Color(0xffddedfe),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          category,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
