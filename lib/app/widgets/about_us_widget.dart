import 'package:flutter/material.dart';

class AboutUsWidget extends StatelessWidget {
  const AboutUsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            child: Text('Hey, we´re Techfrenetic.'),
          ),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          ElevatedButton(
            onPressed: null,
            child: Text('data'),
          )
        ],
      ),
    );
  }
}
