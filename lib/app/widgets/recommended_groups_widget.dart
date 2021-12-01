import 'package:flutter/material.dart';

class RecommendedGroupsWidget extends StatefulWidget {
  RecommendedGroupsWidget({Key? key}) : super(key: key);

  @override
  _RecommendedGroupsWidgetState createState() =>
      _RecommendedGroupsWidgetState();
}

class _RecommendedGroupsWidgetState extends State<RecommendedGroupsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1.00,
            color: Theme.of(context).primaryColor,
          ),
          left: BorderSide(
            width: 0.50,
            color: Colors.grey.withOpacity(.6),
          ),
          right: BorderSide(
            width: 0.50,
            color: Colors.grey.withOpacity(.6),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text('data')],
      ),
    );
  }
}
