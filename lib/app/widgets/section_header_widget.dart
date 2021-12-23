import 'package:flutter/material.dart';

class SectionHeaderWidget extends StatelessWidget {
  const SectionHeaderWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child,
        const SizedBox(
          height: 5,
        ),
        Container(
          color: Colors.black,
          height: 1.5,
          width: 400,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
