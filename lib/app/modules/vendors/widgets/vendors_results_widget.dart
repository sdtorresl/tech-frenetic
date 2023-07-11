import 'package:flutter/material.dart';

class VendorsResultsWidget extends StatelessWidget {
  final String title;
  const VendorsResultsWidget({Key? key, this.title = "VendorsResultsWidget"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(title));
  }
}